
 CREATE PROCEDURE pp_EquipmentTimesheets @DocNbr VARCHAR(10), @LineNbr SmallInt, 
                                   @SolUser Varchar(10), @gEnd_Date As SmallDateTime, @EquipmentID VARCHAR(10), 
                                   @HdrTH_Date As SmallDateTime, @ProgID VARCHAR(8), @gUZActive INTEGER,
                                   @AllowPostingPriorPeriods VARCHAR(1), @GLBatch VARCHAR(1), @PPResult INT OUTPUT, @ErrTable VARCHAR(20) OUTPUT                             
AS
--@AllowPostingPriorPeriods 'Y' - Yes  'N' - No
   DECLARE @ERRORNBR INT
   DECLARE @Detail_Num INT
   DECLARE @Detail_NumOffSet INT
   DECLARE @ProceedWithUZCalc VARCHAR(3)
   DECLARE @UZPeriod VARCHAR(10)
   
  --Posting VARIABLES
  DECLARE @gPostPeriod VARCHAR(6)
  DECLARE @MaxWeDate AS SmallDateTime
  DECLARE @thePeriod VARCHAR(6)
  
  DECLARE @fsyear_num VARCHAR(4)
  
  --PJCONTRL VARIABLES
  DECLARE @gEQ_Charge_Acct VARCHAR(16)
  DECLARE @gEQ_Offset_Acct VARCHAR(16)
  DECLARE @gEQ_Charge_GLAcct VARCHAR(10)
  DECLARE @gEQ_Offset_GlAcct VARCHAR(10)
  DECLARE @gUOP_Charge_Acct VARCHAR(16)
  DECLARE @gAllocOption VARCHAR(2)  
  DECLARE @gCurrentPeriod VARCHAR(6)
  DECLARE @MSP_Interface VARCHAR(1) -- Y is True 
  
  --PJEQUIP VARIABLES
  DECLARE @PostEquipToGL VARCHAR(1)
  DECLARE @OffsetProjectPosting VARCHAR(1)
  DECLARE @EquipGl_SubAcct VARCHAR(24)
  DECLARE @EquipProjectCostBasis VARCHAR(16)
  DECLARE @OffSetTask VARCHAR(32)  --First Task Associated with the CostBasis
  
  --PJTIMDET VARIABLES
  DECLARE @TimDetTask VARCHAR(32)
  DECLARE @TimDetProject VARCHAR(16)
  DECLARE @TimDetEquipID VARCHAR(10)
  DECLARE @TimDetEquipUnits FLOAT
  DECLARE @TimDetEquipAmt FLOAT
  DECLARE @TimDetGLAcct VARCHAR(10)
  DECLARE @TimDetGLSubAcct VARCHAR(24)
  DECLARE @TimDetEmployee VARCHAR(10)
  DECLARE @TimDetDate SmallDateTime
  DECLARE @TimDetSubTaskName VARCHAR(50)
  
  --GLSETUP
  DECLARE @GLPerNbr VARCHAR(6)
  DECLARE @BaseCuryID VARCHAR(4)

  DECLARE @BasePrecision INT

  --PROJECT CURRENCY VARIABLES
  DECLARE @ProjCuryID VARCHAR(4)
  DECLARE @ProjCuryPrecision INT   
  DECLARE @ProjCurrencyRate AS FLOAT
  DECLARE @CurrencyRate FLOAT
  DECLARE @ProjCuryRateType VARCHAR(6)
  DECLARE @CurrencyMultDiv VARCHAR(1)
  DECLARE @ProjCury_amount FLOAT
  DECLARE @ProjCuryEffDate SMALLDATETIME
    
 --Acct categories and GL accts from Foundation Setup screen PA.SET
 SELECT @gEQ_Charge_Acct = RTRIM(SUBSTRING(c.control_data,1,16)), @gEQ_Offset_Acct = RTRIM(SUBSTRING(c.control_data,17,16)),
        @gEQ_Charge_GLAcct = RTRIM(SUBSTRING(c.control_data,33,10)), @gEQ_Offset_GlAcct = RTRIM(SUBSTRING(c.control_data,43,10)),
        @gUOP_Charge_Acct = RTRIM(SUBSTRING(c.control_data,53,16))
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'PA' AND c.control_code = 'TIMESHEET-INFO'
  IF @@ERROR <> 0
     BEGIN
        SET @ERRORNBR = 400
        SET @ErrTable = 'PJCONTRL'
        GOTO ABORT
     END
 
 -- Allocation posting options
  SELECT @gAllocOption = RTRIM(SUBSTRING(c.control_data,1,2))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'ALLOC-AUTO'
   
  SELECT @gCurrentPeriod = RTRIM(SUBSTRING(c.control_data,1,6))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'CURRENT-PERIOD'
   
  SELECT @MSP_Interface = RTRIM(SUBSTRING(c.control_data,1,1))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'MSP-INTERFACE'   
   
 If @gEQ_Charge_Acct = '' OR @gEQ_Charge_GLAcct = ''
    BEGIN
       SET @ERRORNBR = 417
       SET @ErrTable = 'PJCONTRL'
       GOTO ABORT
    END
 
 SELECT @PostEquipToGL = SUBSTRING(e.er_id05,2,1), @OffsetProjectPosting = SUBSTRING(e.er_id05,1,1),
        @EquipProjectCostBasis = e.project_costbasis, @EquipGl_SubAcct = e.gl_subacct 
   FROM PJEQUIP e WITH(NOLOCK)
  WHERE e.equip_id = @EquipmentID
  IF @@ERROR <> 0
     BEGIN
        SET @ERRORNBR = 425
        SET @ErrTable = 'PJEQUIP'
        GOTO ABORT
     END
  
 SELECT @TimDetTask = d.pjt_entity, @TimDetProject = d.project, @TimDetEquipID = d.equip_id, @TimDetEquipUnits = d.equip_units, 
        @TimDetEquipAmt = d.equip_amt, @TimDetGLAcct = d.gl_acct, @TimDetGLSubAcct = d.gl_subacct, 
        @TimDetEmployee = CASE d.employee WHEN 'NONE' THEN '' ELSE d.employee END, @TimDetDate = d.tl_date,
        @TimDetSubTaskName = d.SubTask_Name
   FROM PJTIMDET d WITH(NOLOCK)
  WHERE d.docnbr = @DocNbr
    AND d.linenbr = @LineNbr
 IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 500
       SET @ErrTable = 'PJTIMDET'
       GOTO ABORT
    END
           
  /***************  Get Posting Period ***************/  
  SET @gPostPeriod = ''
    
  SELECT @MaxWeDate = ISNULL(MAX(we_date), '1900-01-01 00:00:00') 
    FROM PJWEEK
   WHERE we_date >= @TimDetDate   
	
  IF @MaxWeDate = '1900-01-01 00:00:00'
     BEGIN
        SET @thePeriod = ''
     END
  ELSE
     BEGIN
        SELECT @thePeriod = w.fiscalno 
          FROM PJWEEK w 
         WHERE we_date = @MaxWeDate    
     END 
        
  IF @thePeriod < @gCurrentPeriod
     BEGIN
        SET @gPostPeriod = @gCurrentPeriod
     END
  ELSE
     BEGIN
        SET @gPostPeriod = @thePeriod
     END
  /*************** End of Posting Period  ***************/     
  SET @fsyear_num = LEFT(@gPostPeriod,4)

 If @OffsetProjectPosting = 'Y'
    BEGIN
       IF @gEQ_Offset_Acct = '' OR @gEQ_Offset_GlAcct = ''
         BEGIN
            SET @ERRORNBR = 517
            SET @ErrTable = 'PJCONTRL'
            GOTO ABORT
         END
         
         IF (SELECT COUNT(*) FROM PJPENT WITH(NOLOCK) WHERE  project = @EquipProjectCostBasis AND (status_pa = 'A' OR status_pa = 'I')) = 0
            BEGIN
               --Error creating equipment offset records.  No task exists for project ($1) which is the project specified in the equipment master for equipment id ($2).                                                                                                        
               SET @ERRORNBR = 430
               SET @ErrTable = 'PJPENT'
               GOTO ABORT
            END  
        
        SET @OffSetTask = (SELECT Top 1(pjt_entity) 
                             FROM PJPENT
                            WHERE project = @EquipProjectCostBasis AND (status_pa = 'A' or status_pa = 'I')
                            ORDER BY project, pjt_entity)   
    END        

 If @PostEquipToGL = 'Y'
    BEGIN
       IF @gEQ_Charge_GLAcct = '' OR @gEQ_Offset_GlAcct = ''
          BEGIN
            SET @ERRORNBR = 518
            SET @ErrTable = 'PJCONTRL'
            GOTO ABORT
          END
       
       SELECT @GLPerNbr = g.PerNbr
         FROM GLSetup g WITH(NOLOCK)
         
       IF @GLPerNbr > @gPostPeriod AND @AllowPostingPriorPeriods = 'N'
          BEGIN
             -- 0097 Period Closed
             SET @ERRORNBR = 525
             SET @ErrTable = 'GLSETUP'
             GOTO ABORT
          END   
    END

  --Get new Detail_Num
  SELECT @Detail_Num = ISNULL(MAX(detail_num), 0) + 1
   FROM PJTran a WITH(NOLOCK) 
  WHERE a.fiscalno = @gPostPeriod AND a.system_cd = 'TM' AND a.batch_id = @DocNbr

  /*************** Start Get_UZPeriod *******************/
  SET @UZPeriod = ''
    
  IF @gUZActive = 1 AND RTRIM(@TimDetEmployee) <> ''
     BEGIN 
        EXEC Get_UZPeriod @TimDetProject, @TimDetEmployee, @gEQ_Charge_Acct, @gPostPeriod, '', @TimDetDate, @UZPeriod OUTPUT 
        IF @@ERROR <> 0
           BEGIN
              SET @ERRORNBR = 600
              SET @ErrTable = 'Utilization Period'
              GOTO ABORT
           END              
     END
  /*************** End of Get_UZPeriod ******************/
  
  SELECT @BaseCuryID = BaseCuryId
    FROM GLSetup WITH(NOLOCK) 
   WHERE setupid = 'GL'  
   
  SELECT @BasePrecision = decpl
    FROM Currncy c WITH(NOLOCK) 
   WHERE c.CuryId = @BaseCuryID

  SELECT @ProjCuryID = PJPROJ.ProjCuryID, @ProjCuryRateType = PJPROJ.ProjCuryRateType,
         @ProjCuryPrecision = COALESCE(Currncy.DecPl, @BasePrecision)
    FROM PJPROJ WITH(NOLOCK) LEFT JOIN Currncy WITH(NOLOCK) 
                               ON Currncy.CuryId = PJPROJ.ProjCuryId
   WHERE PJPROJ.project = @TimDetProject 

  IF @BaseCuryID = @ProjCuryID
     BEGIN
        SET @ProjCurrencyRate = 1
        SET @ProjCuryEffDate = GETDATE()
        SET @ProjCury_amount = @TimDetEquipAmt
        SET @ProjCuryRateType = ''
     END
  ELSE  
     BEGIN
        SET @CurrencyRate = ISNULL((SELECT Top 1(rate) 
                                      FROM CuryRate WITH(NOLOCK)
                                     WHERE FromCuryId like @BaseCuryID
                                       AND ToCuryId like @ProjCuryID 
                                       AND RateType like @ProjCuryRateType
                                       AND EffDate <= @TimDetDate
                                     ORDER BY FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC),0)
        IF @CurrencyRate = 0 
           BEGIN
              SET @ERRORNBR = 1789
              SET @ErrTable = 'CuryRate'
              GOTO ABORT
           END
        SET @CurrencyMultDiv = ISNULL((SELECT Top 1(MultDiv) 
                                         FROM CuryRate WITH(NOLOCK)
                                        WHERE FromCuryId like @BaseCuryID
                                          AND ToCuryId like @ProjCuryID 
                                          AND RateType like @ProjCuryRateType
                                          AND EffDate <= @TimDetDate
                                          AND rate = @CurrencyRate
                                        ORDER BY FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC),0)      
        SET @ProjCuryEffDate = @TimDetDate
        SET @ProjCury_amount = CASE @CurrencyMultDiv 
                                 WHEN 'M' THEN ROUND(@TimDetEquipAmt * @CurrencyRate, @ProjCuryPrecision) 
                                          ELSE ROUND(@TimDetEquipAmt / @CurrencyRate, @ProjCuryPrecision) END 
        SET @ProjCurrencyRate = CASE WHEN ROUND(@TimDetEquipAmt / @ProjCury_amount, 9) < 0 
                                          THEN ROUND(@TimDetEquipAmt / @ProjCury_amount, 9) * -1
                                          ELSE ROUND(@TimDetEquipAmt / @ProjCury_amount, 9) END
     END
    
  EXEC pp_CreateEquipmentTrans @TimDetProject, @TimDetTask, @gEQ_Charge_Acct, @gEQ_Charge_GLAcct, 
                               @TimDetGLSubAcct, @DocNbr, @LineNbr, @Detail_Num, @UZPeriod,
                               @gAllocOption, @gPostPeriod, @PostEquipToGL, @ProgID, @SolUser, 
                               @ProjCury_amount, @ProjCurrencyRate, @ProjCuryID, @ProjCuryEffDate,
                               @PPResult OUTPUT
  If @PPResult <> 0
     BEGIN
        --3000, 3100, 3200
        SET @ERRORNBR = @PPResult
        SET @ErrTable = CASE @PPResult WHEN 3000 THEN 'PJTRAN'
                                       WHEN 3100 THEN 'PJTRANEX'
                                       WHEN 3200 THEN 'PJTRANWK' ELSE '' END
        GOTO ABORT
     END
 
  EXEC pp_TimesheetUPDATE_PJACTRolACTSum @gEQ_Charge_Acct, @gPostPeriod, @TimDetProject, @TimDetTask,
                                         @TimDetEquipAmt, @TimDetEquipUnits, @ProgID, @SolUser, 
                                         @ProjCury_amount, @ProjCuryPrecision, @BasePrecision,
                                         @PPResult OUTPUT, @ErrTable OUTPUT
  If @PPResult <> 0
     BEGIN
        --1000, 1100, 1200, 1300
        SET @ERRORNBR = @PPResult
        GOTO ABORT
     END
 
  EXEC pp_TimesheetUPDATE_PJPTDRolPTDSum @gEQ_Charge_Acct, @TimDetProject, @TimDetTask, @TimDetEquipAmt,
                                         @TimDetEquipUnits, @ProgID, @SolUser, @TimDetEmployee, @TimDetSubTaskName,
                                         @gUZActive, @UZPeriod, @MSP_Interface, 
                                         @ProjCury_amount, @ProjCuryPrecision, @BasePrecision,
                                         @PPResult OUTPUT, @ErrTable OUTPUT  
  If @PPResult <> 0
     BEGIN
        --2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
        SET @ERRORNBR = @PPResult
        GOTO ABORT
     END 
 
 
  If @OffsetProjectPosting = 'Y'
      BEGIN
         --Post Offset
         
         --Get new Detail_Num
         SELECT @Detail_NumOffSet = ISNULL(MAX(detail_num), 0) + 1
           FROM PJTran a WITH(NOLOCK) 
          WHERE a.fiscalno = @gPostPeriod AND a.system_cd = 'TM' AND a.batch_id = @DocNbr

         EXEC pp_CreateEquipmentTrans @EquipProjectCostBasis, @OffSetTask, @gEQ_Offset_Acct, @gEQ_Offset_GlAcct, 
                                      @EquipGl_SubAcct, @DocNbr, @LineNbr, @Detail_NumOffSet, @UZPeriod,
                                      @gAllocOption, @gPostPeriod, @PostEquipToGL, @ProgID, @SolUser, 
                                      @ProjCury_amount, @ProjCurrencyRate, @ProjCuryID, @ProjCuryEffDate,
                                      @PPResult OUTPUT
         If @PPResult <> 0
            BEGIN
               --3000, 3100, 3200
               SET @ERRORNBR = @PPResult + 1  -- 3001, 3101, 3201 for Offsetting call.
               SET @ErrTable = CASE @PPResult WHEN 3000 THEN 'PJTRAN'
                                              WHEN 3100 THEN 'PJTRANEX'
                                              WHEN 3200 THEN 'PJTRANWK' ELSE '' END
               GOTO ABORT
            END 
            
         EXEC pp_TimesheetUPDATE_PJACTRolACTSum @gEQ_Offset_Acct, @gPostPeriod, @EquipProjectCostBasis, @OffSetTask,
                                         @TimDetEquipAmt, @TimDetEquipUnits, @ProgID, @SolUser, 
                                         @ProjCury_amount, @ProjCuryPrecision, @BasePrecision,
                                         @PPResult OUTPUT, @ErrTable OUTPUT
         If @PPResult <> 0
            BEGIN
               --1000, 1100, 1200, 1300
               SET @ERRORNBR = @PPResult + 1  -- 1001, 1101, 1201, 1301 for Offsetting call.
               GOTO ABORT
            END    
            
         EXEC pp_TimesheetUPDATE_PJPTDRolPTDSum @gEQ_Offset_Acct, @EquipProjectCostBasis, @OffSetTask, @TimDetEquipAmt,
                                         @TimDetEquipUnits, @ProgID, @SolUser, @TimDetEmployee, @TimDetSubTaskName,
                                         @gUZActive, @UZPeriod, @MSP_Interface, 
                                         @ProjCury_amount, @ProjCuryPrecision, @BasePrecision,
                                         @PPResult OUTPUT, @ErrTable OUTPUT  
         If @PPResult <> 0
            BEGIN
               ----2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
               SET @ERRORNBR = @PPResult + 1  -- 2001, 2101, 2201, 2301, 2401, 2501, 2601, 2701, 2801 Adding 1 for Offsetting call.
               GOTO ABORT
            END         
      END     
     
 SELECT @PPResult = 0
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
    400 - GL Accts and & Acct Categories
    417 - Charge Accounts are Blank
    425 - Equipment 
    500 - PJTimDet fetch
    517 - Offset Accounts are Blank
    525 - Posting to Closed Period
    600 - Utilization Period
    3000 & 3001 - PJTran
    3100 & 3101 - PJTranEx
    3200 & 3201 - PJTranWrk
    1000 & 1001 - PJACTROL Insert
    1100 & 1101 - PJACTROL Update
    1200 & 1201 - PJACTSUM Insert
    1300 & 1301 - PJACTSUM Update    
    2000 & 2001 - PJPTDROL Insert
    2100 & 2101 - PJPTDROL Update
    2200 & 2201 - Error Selecting Project Employee Utilization Information
    2300 & 2301 - PJUTLROL Insert 
    2400 & 2401 - PJUTLROL Update
    2500 & 2501 - PJPENTEM Insert  
    2600 & 2601 - PJPENTEM Update 
    2700 & 2701 - PJPTDSUM Insert
    2800 & 2801 -  PJPTDSUM Update
 **/
 SELECT @PPResult = @ERRORNBR

 FINISH:
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_EquipmentTimesheets] TO [MSDSL]
    AS [dbo];

