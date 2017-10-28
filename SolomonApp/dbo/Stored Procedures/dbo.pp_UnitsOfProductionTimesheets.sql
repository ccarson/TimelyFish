
 CREATE PROCEDURE pp_UnitsOfProductionTimesheets @DocNbr VARCHAR(10), @SolUser Varchar(10),
                                                 @ProgID VARCHAR(8), @gUZActive INT, 
                                                 @PPResult INT OUTPUT, @PPProdLineNbr VARCHAR(11) OUTPUT, @PPErrTable VARCHAR(20) OUTPUT                                                 
AS
   DECLARE @ERRORNBR INT
   DECLARE @Detail_Num INT
   DECLARE @FirstRow VARCHAR(1)
   DECLARE @UZPeriod VARCHAR(10)
   DECLARE @UZEmployee VARCHAR(10)
   SET @FirstRow = 'Y'
   
  --Posting VARIABLES
  DECLARE @gPostPeriod VARCHAR(6)
  DECLARE @MaxWeDate AS SmallDateTime
  DECLARE @thePeriod VARCHAR(6)
  SET @gPostPeriod = ''
  
  --PJCONTRL VARIABLES
  DECLARE @gEQ_Charge_Acct VARCHAR(16)
  DECLARE @gEQ_Offset_Acct VARCHAR(16)
  DECLARE @gEQ_Charge_GLAcct VARCHAR(10)
  DECLARE @gEQ_Offset_GlAcct VARCHAR(10)
  DECLARE @gUOP_Charge_Acct VARCHAR(16)
  DECLARE @gAllocOption VARCHAR(2)  
  DECLARE @gCurrentPeriod VARCHAR(6)
  DECLARE @MSP_Interface VARCHAR(1) -- Y is True 
  
  --PJUOPDT VARIABLES
  DECLARE @UOP_LineNbr INTEGER
  DECLARE @UOP_Project VARCHAR(16)  
  DECLARE @UOP_Task VARCHAR(32)
  DECLARE @UOP_Date SmallDateTime
  DECLARE @UOP_Prod_units FLOAT
  
  --PJTIMHDR VARIABLES
  DECLARE @HdrMulti_emp_sw VARCHAR(1)
  DECLARE @HdrPreParerID VARCHAR(10)
  
  --GLSETUP
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
  
  SET @PPProdLineNbr = ''
    
 --Acct categories and GL accts from Foundation Setup screen PA.SET
 SELECT @gEQ_Charge_Acct = RTRIM(SUBSTRING(c.control_data,1,16)), @gEQ_Offset_Acct = RTRIM(SUBSTRING(c.control_data,17,16)),
        @gEQ_Charge_GLAcct = RTRIM(SUBSTRING(c.control_data,33,10)), @gEQ_Offset_GlAcct = RTRIM(SUBSTRING(c.control_data,43,10)),
        @gUOP_Charge_Acct = RTRIM(SUBSTRING(c.control_data,53,16))
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'PA' AND c.control_code = 'TIMESHEET-INFO' 
 IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 800
       SET @PPErrTable = 'PJCONTRL'
       GOTO ABORT
    END
 
  --Allocation posting options
  SELECT @gAllocOption = RTRIM(SUBSTRING(c.control_data,1,2))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'ALLOC-AUTO'
   
  SELECT @gCurrentPeriod = RTRIM(SUBSTRING(c.control_data,1,6))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'CURRENT-PERIOD'
   
  SELECT @MSP_Interface = RTRIM(SUBSTRING(c.control_data,1,1))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'MSP-INTERFACE'   
   
  SELECT @HdrMulti_emp_sw = h.multi_emp_sw, @HdrPreParerID = h.preparer_id 
    FROM PJTIMHDR h WITH(NOLOCK)
   WHERE h.docnbr = @DocNbr
     
 If @gUOP_Charge_Acct = '' 
    BEGIN
       SET @ERRORNBR = 817 --0417
       SET @PPProdLineNbr = ''
       SET @PPErrTable = 'PJCONTRL'
       GOTO ABORT
    END
 
   SELECT @BaseCuryID = BaseCuryId
    FROM GLSetup WITH(NOLOCK) 
   WHERE setupid = 'GL'  
   
  SELECT @BasePrecision = decpl
    FROM Currncy c WITH(NOLOCK) 
   WHERE c.CuryId = @BaseCuryID
   
 DECLARE UnitsOfProd_Csr INSENSITIVE CURSOR FOR
  SELECT p.linenbr, p.project, p.pjt_entity, up_date, prod_units   
    FROM PJUOPDET p
   WHERE p.docnbr = @DocNbr
   ORDER BY p.docnbr,p.linenbr
 
 OPEN UnitsOfProd_Csr     
 FETCH UnitsOfProd_Csr INTO @UOP_LineNbr, @UOP_Project, @UOP_Task, @UOP_Date, @UOP_Prod_units
 IF @@ERROR <> 0
    BEGIN
       CLOSE UnitsOfProd_Csr
       DEALLOCATE UnitsOfProd_Csr
       SET @ERRORNBR = 820
       SET @PPProdLineNbr = ''
       SET @PPErrTable = 'PJUOPDET'
       GOTO ABORT
    END  
               
 WHILE @@FETCH_STATUS = 0
    BEGIN
        If @gPostPeriod = ''
        BEGIN
           /***************  Get Posting Period ***************/  
               
           SELECT @MaxWeDate = ISNULL(MAX(we_date), '1900-01-01 00:00:00') 
             FROM PJWEEK
            WHERE we_date >= @UOP_Date   
	
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
        END
        
        /*************** Start Get_UZPeriod *******************/
        SET @UZPeriod = ''
        SET @UZEmployee = ''
        IF @HdrMulti_emp_sw <> 'Y'
           SET @UZEmployee = @HdrPreParerID
    
        IF @gUZActive = 1 
           BEGIN 
              IF @HdrMulti_emp_sw <> 'Y'
                 BEGIN
                    EXEC Get_UZPeriod @UOP_Project, @UZEmployee, @gUOP_Charge_Acct, @gPostPeriod, '', @UOP_Date, @UZPeriod OUTPUT 
                    IF @@ERROR <> 0
                       BEGIN
                          CLOSE UnitsOfProd_Csr
                          DEALLOCATE UnitsOfProd_Csr
                          SET @ERRORNBR = 825
                          SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
                          SET @PPErrTable = 'Utilization Period'
                       END
                 END      
           END
        /*************** End of Get_UZPeriod ******************/
    
        If @FirstRow = 'Y'
           BEGIN
             --Get new Detail_Num
             SELECT @Detail_Num = ISNULL(MAX(detail_num), 0) + 1
               FROM PJTran a WITH(NOLOCK) 
              WHERE a.fiscalno = @gPostPeriod AND a.system_cd = 'TM' AND a.batch_id = @DocNbr                 
             IF @@ERROR <> 0
                BEGIN
                   CLOSE UnitsOfProd_Csr
                   DEALLOCATE UnitsOfProd_Csr
                   SET @ERRORNBR = 830
                   SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
                   SET @PPErrTable = 'PJTRAN'
                   GOTO ABORT
                END    
                
              SET @FirstRow = 'N'
           END
           
        SELECT @ProjCuryID = PJPROJ.ProjCuryID, @ProjCuryRateType = PJPROJ.ProjCuryRateType,
               @ProjCuryPrecision = COALESCE(Currncy.DecPl, @BasePrecision)
          FROM PJPROJ WITH(NOLOCK) LEFT JOIN Currncy WITH(NOLOCK) 
                                   ON Currncy.CuryId = PJPROJ.ProjCuryId
         WHERE PJPROJ.project = @UOP_Project 

        IF @BaseCuryID = @ProjCuryID
           BEGIN
             SET @ProjCurrencyRate = 1
             SET @ProjCuryEffDate = GETDATE()
             SET @ProjCury_amount = 0
             SET @ProjCuryRateType = ''
           END
        ELSE  
           BEGIN
             SET @ProjCurrencyRate = ISNULL((SELECT Top 1(RateReciprocal) 
                                           FROM CuryRate WITH(NOLOCK)
                                          WHERE FromCuryId like @BaseCuryID
                                            AND ToCuryId like @ProjCuryID 
                                            AND RateType like @ProjCuryRateType
                                            AND EffDate <= @UOP_Date
                                          ORDER BY FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC),0)
        IF @CurrencyRate = 0 
           BEGIN
              CLOSE UnitsOfProd_Csr
              DEALLOCATE UnitsOfProd_Csr
              SET @ERRORNBR = 1789
              SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
              SET @PPErrTable = 'CuryRate'
              GOTO ABORT
           END
        SET @CurrencyMultDiv = 'M'     
        SET @ProjCuryEffDate = @UOP_Date
        SET @ProjCury_amount = 0
     END
  
        INSERT PJTran (acct, alloc_flag, amount, BaseCuryId, batch_id, 
                batch_type, bill_batch_id, CpnyId, crtd_datetime, crtd_prog, 
                crtd_user, CuryEffDate, CuryId, CuryMultDiv, CuryRate, 
                CuryRateType, CuryTranamt, data1, 
                detail_num, employee, 
                fiscalno, gl_acct, gl_subacct, lupd_datetime, lupd_prog, 
                lupd_user, noteid, pjt_entity, post_date, project, 
                Subcontract, SubTask_Name, system_cd, trans_date, tr_comment, 
                tr_id01, tr_id02, tr_id03, tr_id04, tr_id05, 
                tr_id06, tr_id07, tr_id08, tr_id09, tr_id10, 
                tr_id23, tr_id24, tr_id25, tr_id26, tr_id27, 
                tr_id28, tr_id29, tr_id30, tr_id31, tr_id32, 
                tr_status, unit_of_measure, units, user1, user2, 
                user3, user4, vendor_num, voucher_line, voucher_num,
                ProjCury_amount, ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate, 
                ProjCuryRateType, TranProjCuryEffDate, TranProjCuryId, TranProjCuryMultiDiv, 
                TranProjCuryRate, TranProjCuryRateType)       
        SELECT @gUOP_Charge_Acct, CASE SUBSTRING(@gAllocOption,1,1) WHEN 'Y' THEN 'A' ELSE '' END, 0, h.BaseCuryId, h.docnbr,
               'UOP', h.docnbr, ISNULL(p.CpnyId,''), GETDATE(), @ProgID, 
               @SolUser, CAST(0x00000000 AS SmallDateTime), h.BaseCuryId, 'M', 1, 
               '', 0, '', 
               @Detail_Num, CASE h. Multi_emp_sw WHEN 'Y' THEN '' ELSE h.preparer_id END, 
               @gPostPeriod, '', '', GETDATE(), @ProgID, 
               @SolUser, 0, u.pjt_entity, CAST(0x00000000 AS SmallDateTime), u.Project, 
               '', '', 'TM', u.up_date, h.th_comment, 
               u.up_id01, u.up_id02, u.up_id03, u.up_id04, u.up_id05, 
               u.up_id08, 0, CAST(0x00000000 AS SmallDateTime), u.up_id09, u.up_id10, 
               '', '', '', @UZPeriod, '',       
               0, CAST(0x00000000 AS SmallDateTime), 0, 0, 0, 
               '', u.prod_uom, u.prod_units, u.user1, u.user2, 
               u.user3, u.user4, '', 0, '',
               @ProjCury_amount, @ProjCuryEffDate, @ProjCuryID , 'M', @ProjCurrencyRate, 
               @ProjCuryRateType, CAST(0x00000000 AS SmallDateTime), '', '', 
               0, ''      
          FROM PJUOPDET u JOIN PJTIMHDR h
                            ON u.docnbr = h.docnbr
                          LEFT OUTER JOIN PJPROJ p WITH(NOLOCK)
                            ON u.project = p.project
         WHERE u.docnbr = @DocNbr
           AND u.linenbr = @UOP_LineNbr 
        IF @@ERROR <> 0
           BEGIN
              CLOSE UnitsOfProd_Csr
              DEALLOCATE UnitsOfProd_Csr
              SET @ERRORNBR = 840
              SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
              SET @PPErrTable = 'PJTRAN'
              GOTO ABORT
           END            

        INSERT PJTRANEX (batch_id, crtd_datetime, crtd_prog, crtd_user, detail_num, 
                         equip_id, fiscalno, invtid, lotsernbr, lupd_datetime, 
                         lupd_prog, lupd_user, orderlineref, ordnbr, shipperid, 
                         shipperlineref, siteid, system_cd, tr_id11, tr_id12, 
                         tr_id13, tr_id14, tr_id15, tr_id16, tr_id17, 
                         tr_id18, tr_id19, tr_id20, tr_id21, tr_id22, 
                         tr_status2, tr_status3, whseloc)

        SELECT u.docnbr, GETDATE(), @ProgID, @SolUser, @Detail_Num, 
               '', @gPostPeriod, '', '', GETDATE(), 
               @ProgID, @SolUser, '', '', '', 
               '', '', 'TM', @gPostPeriod + 'TM' + u.docnbr + RIGHT('0000000000' + CAST(@Detail_Num AS VARCHAR(10)), 10), '', 
               '', '', '', '', '', 
               '', '', '', '', CAST(0x00000000 AS SmallDateTime), 
               '', '', ''
          FROM PJUOPDET u 
         WHERE u.docnbr = @DocNbr
           AND u.linenbr = @UOP_LineNbr 
        IF @@ERROR <> 0
           BEGIN
              CLOSE UnitsOfProd_Csr
              DEALLOCATE UnitsOfProd_Csr
              SET @ERRORNBR = 850
              SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
              SET @PPErrTable = 'PJTRANEX'
             GOTO ABORT
        END       

        IF SUBSTRING(@gAllocOption,1,1) = 'Y'
           BEGIN
              INSERT PJTRANWK (acct, alloc_flag, amount, BaseCuryId, batch_id, 
                               batch_type, bill_batch_id, CpnyId, crtd_datetime, crtd_prog, 
                               crtd_user, CuryEffDate, CuryId, CuryMultDiv, CuryRate, 
                               CuryRateType, CuryTranamt, data1, detail_num, employee, 
                               fiscalno, gl_acct, gl_subacct, lupd_datetime, lupd_prog, 
                               lupd_user, noteid, pjt_entity, post_date, project, 
                               Subcontract, SubTask_Name, system_cd, trans_date, tr_comment, 
                               tr_id01, tr_id02, tr_id03, tr_id04, tr_id05, 
                               tr_id06, tr_id07, tr_id08, tr_id09, tr_id10, 
                               tr_id23, tr_id24, tr_id25, tr_id26, tr_id27, 
                               tr_id28, tr_id29, tr_id30, tr_id31, tr_id32, 
                               tr_status, unit_of_measure, units, user1, user2, 
                               user3, user4, vendor_num, voucher_line, voucher_num, 
                               alloc_batch,
                               ProjCury_amount, ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate, 
                               ProjCuryRateType, TranProjCuryEffDate, TranProjCuryId, TranProjCuryMultiDiv, 
                               TranProjCuryRate, TranProjCuryRateType)       
              SELECT p.acct, p.alloc_flag, p.amount, p.BaseCuryId, p.batch_id, 
                     p.batch_type, p.bill_batch_id, p.CpnyId, p.crtd_datetime, p.crtd_prog, 
                     p.crtd_user, p.CuryEffDate, p.CuryId, p.CuryMultDiv, p.CuryRate, 
                     p.CuryRateType, p.CuryTranamt, p.data1, p.detail_num, p.employee, 
                     p.fiscalno, p.gl_acct, p.gl_subacct, p.lupd_datetime, p.lupd_prog, 
                     p.lupd_user, p.noteid, p.pjt_entity, p.post_date, p.project, 
                     p.Subcontract, p.SubTask_Name, p.system_cd, p.trans_date, p.tr_comment, 
                     p.tr_id01, p.tr_id02, p.tr_id03, p.tr_id04, p.tr_id05, 
                     p.tr_id06, p.tr_id07, p.tr_id08, p.tr_id09, p.tr_id10, 
                     p.tr_id23, p.tr_id24, p.tr_id25, p.tr_id26, p.tr_id27, 
                     p.tr_id28, p.tr_id29, p.tr_id30, p.tr_id31, p.tr_id32, 
                     p.tr_status, p.unit_of_measure, p.units, p.user1, p.user2, 
                     p.user3, p.user4, p.vendor_num, p.voucher_line, p.voucher_num, 
                     ' ',
                     p.ProjCury_amount, p.ProjCuryEffDate, p.ProjCuryId, p.ProjCuryMultiDiv, p.ProjCuryRate, 
                     p.ProjCuryRateType, p.TranProjCuryEffDate, p.TranProjCuryId, p.TranProjCuryMultiDiv, 
                     p.TranProjCuryRate, p.TranProjCuryRateType
                FROM PJTran p WITH(NOLOCK)
               WHERE p.fiscalno = @gPostPeriod
                 AND p.system_cd = 'TM'
                 AND p.batch_id = @DocNbr
                 AND p.detail_num = @Detail_Num
              IF @@ERROR <> 0
                 BEGIN
                    CLOSE UnitsOfProd_Csr
                    DEALLOCATE UnitsOfProd_Csr           
                    SET @ERRORNBR = 860
                    SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
                    SET @PPErrTable = 'PJTRANWRK'
                    GOTO ABORT
                 END         
           END
        
        EXEC pp_TimesheetUPDATE_PJACTRolACTSum @gUOP_Charge_Acct, @gPostPeriod, @UOP_Project, @UOP_Task,
                                               0, @UOP_Prod_units, @ProgID, @SolUser, 
                                               @ProjCury_amount, @ProjCuryPrecision, @BasePrecision,
                                               @PPResult OUTPUT, @PPErrTable OUTPUT
        If @PPResult <> 0
           BEGIN
              -- 1000, 1100, 1200, 1300
              CLOSE UnitsOfProd_Csr
              DEALLOCATE UnitsOfProd_Csr 
              SET @ERRORNBR = @PPResult + 2     --Add 2 for Units of Production Errors 1002, 1102, 1202, 1302
              SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
              GOTO ABORT
           END
           
        EXEC pp_TimesheetUPDATE_PJPTDRolPTDSum @gUOP_Charge_Acct, @UOP_Project, @UOP_Task, 0,
                                         @UOP_Prod_units, @ProgID, @SolUser, @UZEmployee, '',
                                         @gUZActive, @UZPeriod, @MSP_Interface, 
                                         @ProjCury_amount, @ProjCuryPrecision, @BasePrecision, 
                                         @PPResult OUTPUT, @PPErrTable OUTPUT  
        If @PPResult <> 0
           BEGIN
              -- 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
              CLOSE UnitsOfProd_Csr
              DEALLOCATE UnitsOfProd_Csr 
              SET @ERRORNBR = @PPResult + 2      --Add 2 for Units of Production Errors 2002, 2102, 2202, 2302, 2402, 2502, 2602, 2702, 2802      
              SET @PPProdLineNbr = CAST(@UOP_LineNbr AS VARCHAR(11))
              GOTO ABORT
           END    
                     
        -- get next record, if any, and loop.
        FETCH UnitsOfProd_Csr INTO @UOP_LineNbr, @UOP_Project, @UOP_Task, @UOP_Date, @UOP_Prod_units   
        IF @@ERROR <> 0
           BEGIN
              CLOSE UnitsOfProd_Csr
              DEALLOCATE UnitsOfProd_Csr
              SET @ERRORNBR = 870
              SET @PPProdLineNbr = ''
              SET @PPErrTable = 'PJUOPDET'
              GOTO ABORT
           END       
    END 
 CLOSE UnitsOfProd_Csr
 DEALLOCATE UnitsOfProd_Csr    
            
 SELECT @PPResult = 0
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
    800 - GL Acctouns and Account Categories
    817 - Blank UOP Charge Accounts
    820 - Units Of Production Fetch (PJUOPDET)
    825 - Utilization Period
    830 - Last Detail Number
    840 - PJTran
    850 - PJTranEx
    860 - PJTranWrk
    870 - Fetch Next Units of Production (PJUOPDET)
    1002 - PJACTROL Insert
    1102 - PJACTROL Update
    1202 - PJACTSUM Insert
    1302 - PJACTSUM Update
    1789 - CuryRate Fetch
    2002 - PJPTDROL Insert
    2102 - PJPTDROL Update
    2202 - Error Selecting Project Employee Utilization Information
    2302 - PJUTLROL Insert 
    2402 - PJUTLROL Update
    2502 - PJPENTEM Insert  
    2602 - PJPENTEM Update 
    2702 - PJPTDSUM Insert
    2802 - PJPTDSUM Update 
 **/
 SELECT @PPResult = @ERRORNBR

 FINISH:
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_UnitsOfProductionTimesheets] TO [MSDSL]
    AS [dbo];

