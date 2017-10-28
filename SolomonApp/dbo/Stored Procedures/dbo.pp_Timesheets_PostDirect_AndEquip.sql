
 CREATE PROCEDURE pp_Timesheets_PostDirect_AndEquip @DocNbr VARCHAR(10), @UserAddress VARCHAR(47), 
                                   @SolUser Varchar(10), @gEnd_Date As SmallDateTime, @HdrTH_Date As SmallDateTime,
                                   @AllowPostingPriorPeriods VARCHAR(1), @ProgID VARCHAR(8), @gUZActive INT, @UserID VARCHAR(47)
AS
--@AllowPostingPriorPeriods 'Y' - Yes  'N' - No
SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

  DECLARE @PPResult INT
  DECLARE @ErrTable VARCHAR(20)
  DECLARE @PPUOPLineNbr VARCHAR(11)
  DECLARE @AccountCategory VARCHAR(16)
  DECLARE @EqipmentTotal FLOAT
  DECLARE @gGLTranLinenbr INTEGER
  DECLARE @GLTranOffsetAmt FLOAT
  DECLARE @FromAcct VARCHAR(10)
  DECLARE @FromSub VARCHAR(10)
  DECLARE @gDRTotal FLOAT
  DECLARE @gCRTotal FLOAT
 SET @gDRTotal = 0
 SET @gCRTotal = 0
  DECLARE @project_costbasis VARCHAR(16)
  DECLARE @NewBatNbr BigInt
  DECLARE @BatNbr VARCHAR(10)
  DECLARE @BatNbrLen INT
  DECLARE @Detail_Num INT
 SET @Detail_Num = 0
 
  DECLARE @Hourly_Rate FLOAT
  DECLARE @Hourly_Rate_NoShift FLOAT
  DECLARE @Rate_Source VARCHAR(1)
  DECLARE @incremental_amt FLOAT
  DECLARE @Wage_difference FLOAT
  DECLARE @Salary_Rate FLOAT
  DECLARE @RoundingAccum FLOAT
 SET @Hourly_Rate = 0
 SET @Salary_Rate = 0
 SET @RoundingAccum = 0
 
  --PJCONTRL VARIABLES
  DECLARE @PostTimesheetDirectly VARCHAR(1)
  DECLARE @tmsetup_post_ot_flg VARCHAR(1)
  DECLARE @tmsetup_ot1_multiplier FLOAT
  DECLARE @tmsetup_ot2_multiplier FLOAT
  DECLARE @gSiteID VARCHAR(4)
  DECLARE @gEQ_Charge_GLAcct VARCHAR(10)
  DECLARE @gEQ_Offset_GlAcct VARCHAR(10)
  
  --Labor Rate Options
  DECLARE @gCost_labor_when VARCHAR(1)
  DECLARE @gLabor_rate_type VARCHAR(2)
  DECLARE @gRate_lookup_method VARCHAR(1)

  --GLSETUP VARIABLES
  DECLARE @GLSetupID VARCHAR(2)
  DECLARE @BaseCuryID VARCHAR(4)
  DECLARE @LedgerID VARCHAR(10)
  
  --MCSETUP VARIABLES
  DECLARE @MCActivated SmallInt
   
  --PJWEEK VARIABLES
  DECLARE @PeriodNum VarChar(6)
  DECLARE @WEDate SmallDateTime
  DECLARE @WeekNum VarChar(2)
   
  DECLARE @HRS_TOTAL FLOAT
  
  --PJEMPPJT
  DECLARE @PayType VARCHAR(4)
  DECLARE @PJEMPPJT_Salary_Rate FLOAT
  DECLARE @PJEMPPJT_Hourly_Rate FLOAT
  DECLARE @PJEMPPJT_ep_id01 VARCHAR(30)
  DECLARE @PJEMPPJT_Labor_Rate FLOAT
  
  --RATE VARIABLES
  DECLARE @PrevailWageHr_Rate FLOAT
  DECLARE @EmpHr_Rate FLOAT
  DECLARE @UnionHr_Rate FLOAT
  DECLARE @RateTableHr_Rate FLOAT
  DECLARE @UseDate SmallDateTime
  DECLARE @LEVEL VARCHAR(2)
  DECLARE @KEY1 VARCHAR(255)
  DECLARE @KEY2 VARCHAR(255)
  DECLARE @KEY3 VARCHAR(255)
  DECLARE @RateTableID VARCHAR(4)
  DECLARE @RateType VARCHAR(2)
  DECLARE @Labor_Cost FLOAT
  DECLARE @Errglabor_ratetable_id VARCHAR(4)
  DECLARE @Errlabor_rate_type VARCHAR(2)
  DECLARE @l1 FLOAT
  DECLARE @l2 FLOAT
  DECLARE @Fringe_Rate FLOAT
  
  --Posting VARIABLES
  DECLARE @gEquipPostPeriod VARCHAR(6)
  DECLARE @EquipMaxWeDate AS SmallDateTime
  DECLARE @EquipthePeriod VARCHAR(6)
  DECLARE @gCurrentPeriod VARCHAR(6)
  
  DECLARE @gPostPeriod VARCHAR(6)  
  DECLARE @MaxWeDate AS SmallDateTime
  DECLARE @thePeriod VARCHAR(6)
  
  --PJWAGEPR VARIABLES
  DECLARE @PJWAGEPR_LaborRate FLOAT
  DECLARE @PJWAGEPR_PrevWageCD VARCHAR(4)
  DECLARE @PJWAGEPR_PW_ID16 FLOAT
 SET @PJWAGEPR_PW_ID16 = 0
  
  --Other Table Fetchs
  DECLARE @PJPROJEX_pm_id14 VARCHAR(16)
  DECLARE @PJPROJEX_pm_id15 VARCHAR(4)
  DECLARE @PJPENT_pe_id03 VARCHAR(16)
  DECLARE @Employee_DfltWrkLoc VARCHAR(6)
  DECLARE @PJCode_Data1 VARCHAR(30)
  DECLARE @PJCode_Data2 VARCHAR(16)
  DECLARE @Work_Rate FLOAT
  DECLARE @Update_LaborRate FLOAT
  
  DECLARE @MsgID INT
  DECLARE @MsgLineNbr VARCHAR(11)
  DECLARE @MsgParms VARCHAR(100)
  DECLARE @MsgTableID VARCHAR(20)
  
  SET @MsgID = 0
  SET @MsgLineNbr = ''
  SET @MsgParms = ''
  
 DELETE FROM WrkTimesheetPostBad
 WHERE UserAddress = @UserAddress
 IF @@ERROR <> 0  GOTO FINISH
  
 --TMSetup - Post Timesheets Directly & First Day of Week in Timecard on General Information.
 SELECT @PostTimesheetDirectly = SUBSTRING(c.control_data,220,1), --@gFirstDay = SUBSTRING(c.control_data,221,3),
        @tmsetup_post_ot_flg = SUBSTRING(c.control_data,153,1), @tmsetup_ot1_multiplier = CAST(SUBSTRING(c.control_data,1,5) AS FLOAT),
        @tmsetup_ot2_multiplier = CAST(SUBSTRING(c.control_data,6,5) AS FLOAT)  
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'SETUP'  
  IF @@ERROR <> 0  GOTO FINISH 
   
 --Labor RAte Options 
 SELECT @gRate_lookup_method = SUBSTRING(c.Control_data,1,1), @gLabor_rate_type = SUBSTRING(c.Control_data,2,2),
        @gCost_labor_when = SUBSTRING(c.Control_data,4,1) 
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'RATE-OPTIONS'  
  IF @@ERROR <> 0  GOTO FINISH   
  
 SELECT @gSiteID = RTRIM(SUBSTRING(c.Control_data,1,4))
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'SITE' 
  If @gSiteID = '' 
  BEGIN
     SET @gSiteID = '0000'
  END
   
  SELECT @gCurrentPeriod = RTRIM(SUBSTRING(c.control_data,1,6))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'CURRENT-PERIOD'
   IF @@ERROR <> 0  GOTO FINISH 

 --Acct categories and GL accts from Foundation Setup screen PA.SET
 SELECT @gEQ_Charge_GLAcct = RTRIM(SUBSTRING(c.control_data,33,10)), @gEQ_Offset_GlAcct = RTRIM(SUBSTRING(c.control_data,43,10))
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'PA' AND c.control_code = 'TIMESHEET-INFO' 
  IF @@ERROR <> 0  GOTO FINISH 
  
  If @PostTimesheetDirectly <> 'Y'
  BEGIN
      --This is only for Posting Directly.
      GOTO FINISH
  END
 
  BEGIN TRANSACTION
 
  SELECT @GLSetupID = SetupId, @BaseCuryID = BaseCuryId, @LedgerID = LedgerID
    FROM GLSetup WITH(NOLOCK)
   WHERE setupid = 'GL'
  IF @@ERROR <> 0 OR @GLSetupID IS NULL
     BEGIN
       SET @MsgID = 98
       SET @MsgLineNbr = ''
       SET @MsgParms = ''
       SET @MsgTableID = 'GLSETUP'
       GOTO ABORT
     END 
  
  SELECT @MCActivated = ISNULL(v.MCActivated, 0) 
    FROM vs_mcsetup v WITH(NOLOCK)
  IF @MCActivated IS NULL
      BEGIN
         SET @MCActivated = 0
      END
 
 SELECT TOP 1 @PeriodNum = w.period_num, @WEDate = w.we_date, @WeekNum = w.week_num 
   FROM PJWEEK w WITH(NOLOCK)
  WHERE w.we_date >= @HdrTH_Date
  ORDER BY w.we_date
 IF @@ERROR <> 0  GOTO FINISH  
 
  SET @EqipmentTotal = 0
  
  SET @gPostPeriod = ''
   
  Create Table #Equip_Wrk (
         DocNbr VARCHAR(10),
         LineNbr INTEGER,
         EquipAmt FLOAT,
         gPostPeriod VARCHAR(6),
         Cpny_chrg VARCHAR(10),
         Cpny_eq_home VARCHAR(10),
         EquipID VARCHAR(10),
         Project VARCHAR(16),
         GL_Subacct VARCHAR(24),
         Equip_Home_Subacct VARCHAR(24))
 
  /** Equipment_Csr Cursor Variables **/
 Declare @Equip_DocNbr Varchar(10), @Equip_LineNbr integer, @Equip_EquipAmt Float, @Equip_PostPeriod VARCHAR(6), @Equip_Cpny_chrg VARCHAR(10), 
         @Equip_Cpny_eq_home VARCHAR(10), @Equip_EquipID VARCHAR(10), @Equip_Project VARCHAR(16), @Equip_GLSubAcct VARCHAR(24), @Equip_EquipHomeSubAcct VARCHAR(24)
 
 /** PJTimDet_Csr Cursor Variables **/
 Declare @DocNbrLine Varchar(10), @LineNbr integer, @Employee VarChar(10), @RegHours Float, @OT1Hours Float,
         @OT2Hours Float, @FlatAmtTL18 Float, @TLDate SmallDateTime, @CpnyIDHome VarChar(10), @tl_status VarChar(1), 
         @EquipID VarChar(10), @EquipAmt Float, @Cpny_chrg VARCHAR(10), @Cpny_eq_home VARCHAR(10), @Project VARCHAR(16), 
         @GL_Subacct VARCHAR(24), @Equip_HomeSubacct VARCHAR(24), @GL_Acct VARCHAR(10), @Task VARCHAR(32), @Shift VARCHAR(7),
         @Cert_Pay_SW VARCHAR(1), @Labor_Class_CD VARCHAR(4), @Group_Code VARCHAR(2), @Union_CD VARCHAR(10), @TL_ID16 VARCHAR(10),
         @Labor_Rate FLOAT, @Work_Type VARCHAR(2)
         
 DECLARE PJTimDet_Csr INSENSITIVE CURSOR FOR
    SELECT  docnbr, linenbr, employee, reg_hours, ot1_hours, ot2_hours, tl_id18, tl_date, CpnyId_home, 
            tl_status, equip_id, equip_amt, CpnyId_chrg, CpnyId_eq_home, Project, gl_subacct, equip_home_subacct, gl_acct, pjt_entity, shift,
            cert_pay_sw, labor_class_cd, group_code, union_cd, tl_id16, labor_rate, work_type 
      FROM PJTIMDET p
     WHERE p.docnbr = @DocNbr 
     ORDER BY p.docnbr, CASE WHEN p.Employee = 'NONE' THEN 2 ELSE 1 END ASC,p.linenbr

 OPEN PJTimDet_Csr
 FETCH PJTimDet_Csr INTO @DocNbrLine, @LineNbr, @Employee, @RegHours, @OT1Hours, @OT2Hours, @FlatAmtTL18, @TLDate, @CpnyIDHome, 
       @tl_status, @EquipID, @EquipAmt, @Cpny_chrg, @Cpny_eq_home, @Project, @GL_Subacct, @Equip_HomeSubacct, @GL_Acct, @Task, @Shift,
       @Cert_Pay_SW, @Labor_Class_CD, @Group_Code, @Union_CD, @TL_ID16, @Labor_Rate, @Work_Type 
 IF @@ERROR <> 0
    BEGIN
      CLOSE PJTimDet_Csr
      DEALLOCATE PJTimDet_Csr
      SET @MsgID = 100
      SET @MsgLineNbr = ''
      SET @MsgParms = ''
      SET @MsgTableID = 'PJTIMDET'
      GOTO ABORT
    END

 WHILE @@FETCH_STATUS = 0
    BEGIN
       SET @Update_LaborRate = @Labor_Rate  --Initialize the variable, becuase HR with gCostLabor of A will change it.
       SET @Rate_Source = 'S'
       If @Employee <> 'NONE' AND (@RegHours <> 0 or @OT1Hours <> 0 or @OT2Hours <> 0 OR @FlatAmtTL18 <> 0) AND @tl_status <> 'P'  --Cycling Through Once for Both Equipment and Employee, so Check for Status <> P here for Employee.
          BEGIN
             IF @gPostPeriod = ''
                BEGIN
                   /***************  Get Posting Period ***************/  
                   SET @gPostPeriod = ''
    
                   SELECT @MaxWeDate = ISNULL(MAX(we_date), '1900-01-01 00:00:00') 
                     FROM PJWEEK
                    WHERE we_date >= @TLDate   
	
                   IF @MaxWeDate = '1900-01-01 00:00:00'
                      BEGIN
                         SET @thePeriod = ''
                      END
                   ELSE
                      BEGIN
                         SELECT @thePeriod = w.fiscalno 
                           FROM PJWEEK w WITH(NOLOCK)
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
                     
                   --Get new Detail_Num
                   SELECT @Detail_Num = ISNULL(MAX(detail_num), 0) + 1
                     FROM PJTran a WITH(NOLOCK) 
                    WHERE a.fiscalno = @gPostPeriod AND a.system_cd = 'TM' AND a.batch_id = @DocNbr
                END
          
             /*********************************   Post Directly   **********************************/
             SET @HRS_TOTAL = ROUND(CONVERT(DEC(28,3),@RegHours) + CONVERT(DEC(28,3), @OT1Hours) + CONVERT(DEC(28,3),@OT2Hours),2)

              SELECT @PayType = ep_id05, @PJEMPPJT_ep_id01 = ep_id01, @PJEMPPJT_Salary_Rate = CASE WHEN ep_id05 = 'S1' or ep_id05 = 'S2' THEN labor_rate ELSE 0 END, 
                     @PJEMPPJT_Hourly_Rate = CASE WHEN ep_id05 = 'S1' or ep_id05 = 'S2' THEN labor_rate ELSE 0 END, @PJEMPPJT_Labor_Rate = labor_rate
                FROM PJEMPPJT                        --Sets bPJEMPPJT1 and bPJEMPPJT2
               WHERE employee = @Employee AND project = 'na' 
                 AND effect_date <= @TLDate 
                
              IF @PayType Is Null   
                 BEGIN
                    --0194 no blank project record available.
                    CLOSE PJTimDet_Csr
                    DEALLOCATE PJTimDet_Csr
                    SET @MsgID = 110
                    SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                    SET @MsgParms = RTRIM(LTRIM(@Employee))
                    SET @MsgTableID = 'PJEMPPJT'
                    GOTO ABORT
                 END
              IF (@PayType = 'S1' or @PayType = 'S2') AND @PJEMPPJT_Salary_Rate = 0
                 BEGIN
                    --0480 Salary Rate is zero.
                    CLOSE PJTimDet_Csr
                    DEALLOCATE PJTimDet_Csr
                    SET @MsgID = 120
                    SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                    SET @MsgParms = RTRIM(LTRIM(@Employee))
                    SET @MsgTableID = 'PJEMPPJT'
                    GOTO ABORT
                 END
              
              SET @Salary_Rate = @PJEMPPJT_Salary_Rate
                
              EXEC Get_Account_Category @GL_Acct, @AccountCategory OUTPUT
              IF @AccountCategory = ''
                 BEGIN
                    --0031 No Account category set up for this gl account
                    CLOSE PJTimDet_Csr
                    DEALLOCATE PJTimDet_Csr
                    SET @MsgID = 31
                    SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                    SET @MsgParms = RTRIM(LTRIM(@GL_Acct)) + ' | ' + RTRIM(LTRIM(@Employee))
                    SET @MsgTableID = ''
                    GOTO ABORT
                 END

              SELECT @PJPROJEX_pm_id14 = PM_ID14, @PJPROJEX_pm_id15 = PM_ID15 
                FROM PJprojex 
               WHERE project = @Project  --bPJPROJEX
              IF @PJPROJEX_pm_id14 IS NULL 
                 SET @PJPROJEX_pm_id14 = ''
              IF @PJPROJEX_pm_id15 IS NULL
                 SET @PJPROJEX_pm_id15 = ''
                  
              SELECT @PJPENT_pe_id03 = pe_id03 FROM PJPENT WHERE project = @Project AND pjt_entity = @Task  --bPJPENT
              IF @PJPENT_pe_id03 IS NULL
                 SET @PJPENT_pe_id03 = ''
                                 
              SELECT @Employee_DfltWrkLoc = DfltWrkloc FROM Employee WHERE EmpId = @Employee  --bEmployee
              IF @Employee_DfltWrkLoc IS NULL
                 SET @Employee_DfltWrkLoc = ''
       
              If @FlatAmtTL18 <> 0
                 BEGIN
                    EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'FLT', 0, 0, @FlatAmtTL18, 'A', @ProgID, @SolUser,
                                            @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                            @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                    If @PPResult <> 0
                       BEGIN
                          CLOSE PJTimDet_Csr
                          DEALLOCATE PJTimDet_Csr
                          SET @MsgID = @PPResult
                          SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                          SET @MsgParms = @MsgParms
                          SET @MsgTableID = @ErrTable
                          GOTO ABORT
                       END              
                    SET @Detail_Num = @Detail_Num + 1                               
                 END
              
             IF @PayType = 'HR'
                BEGIN
                  --Get_PrevWageRate
                  SET @PrevailWageHr_Rate = 0
                  IF @Cert_Pay_SW = 'Y'
                     BEGIN
                        IF @PJPROJEX_pm_id15 <> ''
                           BEGIN
                              SELECT TOP 1 @PJWAGEPR_PrevWageCD = prev_wage_cd, @PrevailWageHr_Rate = labor_rate,
                                           @PJWAGEPR_PW_ID16 = pw_id16 
                                FROM PJWAGEPR    --bPJWAGEPR
                               WHERE prev_wage_cd = @PJPROJEX_pm_id15
                                 AND labor_class_cd = @Labor_Class_CD 
                                 AND group_code = CASE WHEN RTRIM(LTRIM(@Group_Code)) = '' THEN 'na' ELSE @Group_Code END
                               ORDER by prev_wage_cd, labor_class_cd, group_code
                               IF @PJWAGEPR_PrevWageCD IS NULL 
                                  BEGIN                                    
                                     SET @PrevailWageHr_Rate = -1
                                     SET @PJWAGEPR_PW_ID16 = 0
                                  END   
                           END
                     END 

                  IF @gCost_labor_when = 'E'  --Costed on Entry
                     BEGIN
                        SET @Hourly_Rate = @Labor_Rate
                        --Backout_Shift
                        SET @Hourly_Rate_NoShift = @Hourly_Rate
                        IF @Cert_Pay_SW = 'y' AND @PJWAGEPR_PW_ID16 <> 0
                           BEGIN
                              If RTRIM(@Shift) <> ''
                                 BEGIN
                                    SELECT @PJCode_Data1 = data1, @PJCode_Data2 = data2 
                                      FROM PJCODE
                                     WHERE code_type = 'SHFT' AND code_value = @Shift
                                     IF @PJCode_Data1 IS NOT NULL
                                        BEGIN
                                            IF CAST(@PJCode_Data2 AS FLOAT) <> 0
                                               BEGIN
                                                  SET @Hourly_Rate_NoShift = ROUND( @Hourly_Rate / (1 + ROUND(CAST(@PJCode_Data2 AS FLOAT) / 100, 2)), 2)
                                               END
                                            SET @Hourly_Rate_NoShift = ROUND(@Hourly_Rate_NoShift - CAST(@PJCode_Data1 AS FLOAT), 2)   
                                        END
                                 END
                           END
                        SET @Rate_Source = LEFT(@TL_ID16,1) 
                     END
                  ELSE   --IF @gCost_labor_when = 'E' 
                     BEGIN
                           --Get_Labor_Rate
                            SET @UseDate = @TLDate
                            If @TLDate = CAST(0x00000000 AS SmallDateTime)
                               SET @UseDate = @HdrTH_Date                         
                            
                            SET @Rate_Source = 'P'
                            SELECT TOP 1 @EmpHr_Rate = labor_rate
                              FROM PJEMPPJT WITH(NOLOCK)
                             WHERE employee = @Employee
                               AND project = CASE WHEN RTRIM(@Project) = '' THEN 'na' ELSE @Project END
                               AND effect_date <= @UseDate
                             ORDER BY employee, project, effect_date desc
                            IF @EmpHr_Rate IS NULL
                               BEGIN
                                  SET @EmpHr_Rate = @PJEMPPJT_Labor_Rate
                                  SET @Rate_Source = 'E'
                               END
                            
                            IF @EmpHr_Rate = -1
                               BEGIN
                                  --SET 0195 
                                  CLOSE PJTimDet_Csr
                                  DEALLOCATE PJTimDet_Csr
                                  SET @MsgID = 150   --0195
                                  SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                                  SET @MsgParms = RTRIM(LTRIM(@Employee))
                                  SET @MsgTableID = ''
                                  GOTO ABORT
                               END   
                            
                            SET @UnionHr_Rate = 0
                            IF RTRIM(LTRIM(@Union_CD)) <> ''
                               BEGIN   
                                  --Get_Union_Rate (@Union_CD, @Labor_Class_CD , @Work_Type, @HdrTH_Date, @TLDate)  --0190
                                  SELECT @UnionHr_Rate = labor_rate 
                                    FROM PJWAGEUN
                                   WHERE union_cd = @Union_CD
                                     AND labor_class_cd = @Labor_Class_CD
                                     AND work_type = CASE WHEN RTRIM(@Work_Type) = '' THEN 'na' ELSE @Work_Type END
                                     AND effect_date <= @UseDate
                                   ORDER BY union_cd, labor_class_cd, work_type, effect_date desc
                                 IF @UnionHr_Rate IS NULL
                                    SET @UnionHr_Rate = -1
                               END
                                                          
                            --Get_RateTable_Rate   --0445
                            EXEC WSL_ProjectRateKeys_OutPut @Project, @LEVEL OUTPUT, @KEY1 OUTPUT, @KEY2 OUTPUT, @KEY3 OUTPUT, @RateTableID OUTPUT, @RateType OUTPUT
                            --SELECT @KEY1, @KEY2, @KEY3
                            EXEC Get_RateTable_Rate_PJTIMDET @Project, @DocNbr, @LineNbr, 
                                              @RateTableHr_Rate OUTPUT, @Errglabor_ratetable_id OUTPUT,
                                              @Errlabor_rate_type OUTPUT
                            IF @RateTableHr_Rate <> -1
                               BEGIN
                                  IF @gRate_lookup_method = 'G'
                                     BEGIN
                                        SET @Work_Rate = @EmpHr_Rate
                                        IF @UnionHr_Rate > @Work_Rate
                                           BEGIN
                                              SET @Work_Rate = @UnionHr_Rate
                                              SET @Rate_Source = 'U'
                                           END
                                        IF @RateTableHr_Rate > @Work_Rate
                                           BEGIN
                                              SET @Work_Rate = @RateTableHr_Rate
                                              SET @Rate_Source = 'F'
                                           END
                                     END
                                  ELSE
                                     BEGIN
                                        IF @RateTableHr_Rate > 0
                                           BEGIN
                                              SET @Work_Rate = @RateTableHr_Rate
                                              SET @Rate_Source = 'F'
                                           END
                                        IF @UnionHr_Rate > 0
                                           BEGIN
                                              SET @Work_Rate = @UnionHr_Rate
                                              SET @Rate_Source = 'U'
                                           END
                                        IF @EmpHr_Rate > 0
                                           BEGIN
                                              SET @Work_Rate = @EmpHr_Rate
                                           END
                                     END   
                                  IF @PrevailWageHr_Rate > @Work_Rate
                                     BEGIN
                                        SET @Work_Rate = @PrevailWageHr_Rate
                                        SET @Rate_Source = 'C'
                                     END
                                  SET @Hourly_Rate = @Work_Rate   
                               END                  
                                             
                            IF @RateTableHr_Rate = -1
                               BEGIN
                                  -- '13135 (0445) 
                                  CLOSE PJTimDet_Csr
                                  DEALLOCATE PJTimDet_Csr
                                  SET @MsgID =  175     --0445
                                  SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                                  SET @MsgParms = RTRIM(LTRIM(@Errglabor_ratetable_id)) + ' | ' + LTRIM(RTRIM(@Errlabor_rate_type))
                                  SET @MsgTableID = ''
                                  GOTO ABORT
                               END
                            IF @UnionHr_Rate = -1 
                               BEGIN
                                  --0190
                                  CLOSE PJTimDet_Csr
                                  DEALLOCATE PJTimDet_Csr
                                  SET @MsgID = 190
                                  SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                                  SET @MsgParms = RTRIM(LTRIM(@Union_CD)) + ' | ' + RTRIM(LTRIM(@Labor_Class_CD)) + ' | ' + RTRIM(LTRIM(@Work_Type))
                                  SET @MsgTableID = ''
                                  GOTO ABORT                                  
                               END
                            IF @PrevailWageHr_Rate = -1
                               BEGIN
                                  --0191  
                                  CLOSE PJTimDet_Csr
                                  DEALLOCATE PJTimDet_Csr
                                  SET @MsgID = 191
                                  SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                                  SET @MsgParms = RTRIM(LTRIM(@PJPROJEX_pm_id15)) + ' | ' + RTRIM(LTRIM(@Labor_Class_CD)) + ' | ' + RTRIM(LTRIM(@Group_Code))
                                  SET @MsgTableID = ''
                                 GOTO ABORT
                               END
                            IF @EmpHr_Rate < 0 AND @UnionHr_Rate = 0 AND @PrevailWageHr_Rate = 0 
                               BEGIN
                                  --0195"  
                                  CLOSE PJTimDet_Csr
                                  DEALLOCATE PJTimDet_Csr
                                  SET @MsgID = 195
                                  SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                                  SET @MsgParms = RTRIM(LTRIM(@Employee))
                                  SET @MsgTableID = ''
                                  GOTO ABORT
                               END
                            SET @Hourly_Rate_NoShift = @Hourly_Rate
                            
                            If RTRIM(@Shift) <> ''
                                 BEGIN
                                    SELECT @PJCode_Data1 = data1, @PJCode_Data2 = data2 
                                      FROM PJCODE
                                     WHERE code_type = 'SHFT' AND code_value = @Shift
                                     IF @PJCode_Data2 IS NOT NULL
                                        BEGIN
                                            SET @incremental_amt = CAST(@PJCode_Data1 AS FLOAT)
                                            SET @Hourly_Rate = ROUND(@Hourly_Rate + @incremental_amt,2)
                                            IF CAST(@PJCode_Data2 AS FLOAT) <> 0
                                               BEGIN
                                                  SET @Hourly_Rate = ROUND( @Hourly_Rate * (1 + ROUND(CAST(@PJCode_Data2 AS FLOAT) / 100, 2)), 2)
                                               END  
                                        END
                                 END
                     END   --ELSE of IF @gCost_labor_when = 'E'                   
                END     --IF @PayType = 'HR'
                
             -- HOURLY
             IF @PayType = 'HR'
                BEGIN
                   SET @Labor_Cost = ROUND(@Hourly_Rate * @RegHours,2)                  
                   EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'REG', @RegHours, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                           @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                           @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                   If @PPResult <> 0
                      BEGIN
                         --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                         CLOSE PJTimDet_Csr
                         DEALLOCATE PJTimDet_Csr
                         SET @MsgID = @PPResult
                         SET @MsgParms = @MsgParms
                         SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                         SET @MsgTableID = @ErrTable
                         GOTO ABORT
                      END              
                   SET @Detail_Num = @Detail_Num + 1   
                
                   IF @tmsetup_post_ot_flg <> 'N'   --separate reg rate from premium                                        
                      BEGIN
                         SET @Labor_Cost = ROUND(@Hourly_Rate * @OT1Hours,2)
                         EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT1', @OT1Hours, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                 @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                 @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                         If @PPResult <> 0
                            BEGIN
                               --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                               CLOSE PJTimDet_Csr
                               DEALLOCATE PJTimDet_Csr
                               SET @MsgID = @PPResult
                               SET @MsgParms = @MsgParms
                               SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))  
                               SET @MsgTableID = @ErrTable                             
                               GOTO ABORT
                            END              
                         SET @Detail_Num = @Detail_Num + 1
                         
                         SET @Labor_Cost = ROUND(@Hourly_Rate * @OT2Hours,2)
                         EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT2', @OT2Hours, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                 @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                 @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                         If @PPResult <> 0
                            BEGIN
                               --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                               CLOSE PJTimDet_Csr
                               DEALLOCATE PJTimDet_Csr
                               SET @MsgID = @PPResult
                               SET @MsgParms = @MsgParms
                               SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))     
                               SET @MsgTableID = @ErrTable                         
                               GOTO ABORT
                            END              
                         SET @Detail_Num = @Detail_Num + 1
                         
                         SET @l1 = ROUND(@tmsetup_ot1_multiplier - 1,2)
                         SET @l2 = ROUND(@Hourly_Rate * @l1, 2)
                         SET @Labor_Cost = ROUND(@OT1hours * @l2, 2)
                         EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT1', 0, @OT1Hours, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                 @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                 @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                         If @PPResult <> 0
                            BEGIN
                               --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                               CLOSE PJTimDet_Csr
                               DEALLOCATE PJTimDet_Csr
                               SET @MsgID = @PPResult
                               SET @MsgParms = @MsgParms
                               SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))  
                               SET @MsgTableID = @ErrTable                             
                               GOTO ABORT
                            END              
                         SET @Detail_Num = @Detail_Num + 1
                         
                         SET @l1 = ROUND(@tmsetup_ot2_multiplier - 1,2)
                         SET @l2 = ROUND(@Hourly_Rate * @l1, 2)
                         SET @Labor_Cost = ROUND(@OT2hours * @l2, 2)
                         EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT2', 0, @OT2Hours, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                 @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                 @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                         If @PPResult <> 0
                            BEGIN
                               --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                               CLOSE PJTimDet_Csr
                               DEALLOCATE PJTimDet_Csr
                               SET @MsgID = @PPResult
                               SET @MsgParms = @MsgParms
                               SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                               SET @MsgTableID = @ErrTable                               
                               GOTO ABORT
                            END              
                         SET @Detail_Num = @Detail_Num + 1                                                  
                      END
                   IF @tmsetup_post_ot_flg = 'N' --'post one entry only for OT 
                      BEGIN
                         SET @l1 = ROUND(@Hourly_Rate, @tmsetup_ot1_multiplier, 2)
                         SET @Labor_Cost = ROUND(@OT1Hours * @l1, 2)
                         
                         EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT1', @OT1Hours, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                 @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                 @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                         If @PPResult <> 0
                            BEGIN
                               --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                               CLOSE PJTimDet_Csr
                               DEALLOCATE PJTimDet_Csr
                               SET @MsgID = @PPResult
                               SET @MsgParms = @MsgParms
                               SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                               SET @MsgTableID = @ErrTable                              
                               GOTO ABORT
                            END              
                         SET @Detail_Num = @Detail_Num + 1 
                         
                         SET @l1 = ROUND(@Hourly_Rate, @tmsetup_ot2_multiplier, 2)
                         SET @Labor_Cost = ROUND(@OT2Hours * @l1, 2)
                         
                         EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT2', @OT2Hours, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                 @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                 @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                         If @PPResult <> 0
                            BEGIN
                               --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                               CLOSE PJTimDet_Csr
                               DEALLOCATE PJTimDet_Csr
                               SET @MsgID = @PPResult
                               SET @MsgParms = @MsgParms
                               SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                               SET @MsgTableID = @ErrTable
                               GOTO ABORT
                            END              
                         SET @Detail_Num = @Detail_Num + 1                                                  
                      END   --IF @tmsetup_post_ot_flg = 'N'
                   
                   IF @Cert_Pay_SW = 'Y' AND @PJWAGEPR_PW_ID16 <> 0
                      BEGIN
                         IF @PrevailWageHr_Rate >= @Hourly_Rate_NoShift
                            BEGIN
                               SET @Fringe_Rate = @PJWAGEPR_PW_ID16
                            END
                         ELSE
                            BEGIN 
                               SET @Wage_difference = ROUND(@Hourly_Rate_NoShift - @PrevailWageHr_Rate, 2)
                               IF @Wage_difference > @PJWAGEPR_PW_ID16
                                  BEGIN
                                     SET @Fringe_Rate = 0
                                  END
                               ELSE
                                  BEGIN
                                     SET @Fringe_Rate = @PJWAGEPR_PW_ID16
                                  END
                            END
                         IF @Fringe_Rate >0
                            BEGIN
                               SET @Labor_Cost = ROUND(@HRS_TOTAL - @Fringe_Rate, 2)
                               EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'FRG', 0, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                       @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                       @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                               If @PPResult <> 0
                                  BEGIN
                                     --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                                     CLOSE PJTimDet_Csr
                                     DEALLOCATE PJTimDet_Csr
                                     SET @MsgID = @PPResult
                                     SET @MsgParms = @MsgParms
                                     SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                                     SET @MsgTableID = @ErrTable
                                     GOTO ABORT
                                  END              
                               SET @Detail_Num = @Detail_Num + 1                                                     
                            END
                      END  --IF @Cert_Pay_SW = 'Y' AND @PJWAGEPR_PW_ID16 <> 0
                END   --IF @PayType = 'HR'
             
             -- Salaried (EXEMPT)   
             If @PayType = 'S1'
                BEGIN
                   SET @l1 = @Salary_Rate * @HRS_TOTAL
                   SET @l2 = ROUND(@Salary_Rate * @HRS_TOTAL, 2)
                   SET @Labor_Cost = @l2
                   EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'REG', @HRS_TOTAL, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                            @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                            @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                   If @PPResult <> 0
                      BEGIN
                         --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                         CLOSE PJTimDet_Csr
                         DEALLOCATE PJTimDet_Csr
                         SET @MsgID = @PPResult
                         SET @MsgParms = @MsgParms
                         SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                         SET @MsgTableID = @ErrTable
                         GOTO ABORT
                      END              
                   SET @Detail_Num = @Detail_Num + 1          
                END   
             
             -- Salaried (NON-EXEMPT)   
             If @PayType = 'S2'
                BEGIN
                   If @RegHours <> 0
                      BEGIN
                         SET @l1 = @Salary_Rate * @RegHours
                         SET @l2 = ROUND(@Salary_Rate * @RegHours, 2)
                         EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'REG', @RegHours, 0, @Labor_Cost, @Rate_Source, @ProgID, @SolUser,
                                                 @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                                 @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                         If @PPResult <> 0
                            BEGIN
                               --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                               CLOSE PJTimDet_Csr
                               DEALLOCATE PJTimDet_Csr
                               SET @MsgID = @PPResult
                               SET @MsgParms = @MsgParms
                               SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                               SET @MsgTableID = @ErrTable
                               GOTO ABORT
                            END              
                         SET @Detail_Num = @Detail_Num + 1                          
                      END
                   SET @Hourly_Rate = @PJEMPPJT_Hourly_Rate
                   SET @Labor_Cost = ROUND(@Hourly_Rate * @OT1Hours, 2)
                   EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT1', @OT1Hours, 0, @Labor_Cost, 'O', @ProgID, @SolUser,
                                            @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                            @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                   If @PPResult <> 0
                      BEGIN
                         --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                         CLOSE PJTimDet_Csr
                         DEALLOCATE PJTimDet_Csr
                         SET @MsgID = @PPResult
                         SET @MsgParms = @MsgParms
                         SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                         SET @MsgTableID = @ErrTable
                         GOTO ABORT
                      END              
                   SET @Detail_Num = @Detail_Num + 1                   

                   SET @Labor_Cost = ROUND(@Hourly_Rate * @OT2Hours, 2)
                   EXEC pp_Post_Labor_Cost @DocNbrLine, @LineNbr, @PayType, 'OT2', @OT2Hours, 0, @Labor_Cost, 'O', @ProgID, @SolUser,
                                            @GL_Acct, @gPostPeriod, @PJPENT_pe_id03, @PJPROJEX_pm_id14,
                                            @gUZActive, @Detail_Num, @gSiteID, @PPResult OUTPUT, @MsgParms OUTPUT, @ErrTable OUTPUT
                   If @PPResult <> 0
                      BEGIN
                         --88, 200, 225, 250, 275, 31, 1000, 1100, 1200, 1300, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800
                         CLOSE PJTimDet_Csr
                         DEALLOCATE PJTimDet_Csr
                         SET @MsgID = @PPResult
                         SET @MsgParms = @MsgParms
                         SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                         SET @MsgTableID = @ErrTable
                         GOTO ABORT
                      END              
                   SET @Detail_Num = @Detail_Num + 1                       
                END 
             
             --Update PJTIMDET with the rate   
             IF @PayType = 'HR' AND @gCost_labor_when = 'A' AND @Labor_Rate <> @Hourly_Rate
                BEGIN
                   SET @Update_LaborRate = @Hourly_Rate
                END
                               
          END  --If @Employee <> 'NONE' AND (@RegHours <> 0 or @OT1Hours <> 0 or @OT2Hours <> 0 OR @FlatAmtTL18 <> 0) AND @tl_status <> 'P'
     
          IF RTRIM(@EquipID) <> ''
             BEGIN
                IF @gPostPeriod = '' AND @Detail_Num = 0
                   BEGIN
                      --Get new Detail_Num
                      SELECT @Detail_Num = ISNULL(MAX(detail_num), 0) + 1
                        FROM PJTran a WITH(NOLOCK) 
                       WHERE a.fiscalno = @gPostPeriod AND a.system_cd = 'TM' AND a.batch_id = @DocNbr
                   END
             
                
                
                EXEC pp_EquipmentTimesheets @DocNbr, @LineNbr,  
                                   @SolUser, @gEnd_Date, @EquipID, 
                                   @HdrTH_Date, @ProgID, @gUZActive,
                                   @AllowPostingPriorPeriods, '', @PPResult OUTPUT, @ErrTable OUTPUT
                IF @PPResult <> 0
                   BEGIN
                      --400, 417, 425, 500, 517, 525, 600, 3000, 3001, 3100, 3101, 3200, 3201, 1000, 1001, 1100, 1101, 1200, 1201, 1300, 1301, 2000, 2001,
                      --2100, 2101, 2200, 2201, 2300, 2301, 2400, 2401, 2500, 2501, 2600, 2601, 2700, 2701, 2800, 2801
                      CLOSE PJTimDet_Csr
                      DEALLOCATE PJTimDet_Csr
                         SET @MsgID = @PPResult
                         SET @MsgParms = LTRIM(RTRIM(@EquipID))
                         SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                         SET @MsgTableID = @ErrTable
                      GOTO ABORT
                   END
                
                --pp_EquipmentTimesheets checks to see if Accts are correct.   
                IF (SELECT SUBSTRING(e.er_id05,2,1) FROM PJEQUIP e WITH(NOLOCK) WHERE e.equip_id = @EquipID) = 'Y' 
                   BEGIN
                      SET @EqipmentTotal = CONVERT(DEC(28,3),@EqipmentTotal) + CONVERT(DEC(28,3),CASE WHEN @EquipAmt < 0 THEN @EquipAmt * -1 ELSE @EquipAmt END)
                      /***************  Get Posting Period ***************/  
                      SET @gEquipPostPeriod = ''
    
                      SELECT TOP 1 @EquipMaxWeDate = ISNULL(we_date, '1900-01-01 00:00:00') 
                        FROM PJWEEK
                         WHERE we_date >= @TLDate
                         ORDER BY we_date ASC   
	
                      IF @EquipMaxWeDate = '1900-01-01 00:00:00' or @EquipMaxWeDate = ''
                         BEGIN
                            SET @EquipthePeriod = ''
                         END
                      ELSE
                         BEGIN
                            SELECT @EquipthePeriod = w.fiscalno 
                              FROM PJWEEK w 
                             WHERE we_date = @EquipMaxWeDate    
                         END 
        
                      IF @EquipthePeriod < @gCurrentPeriod
                         BEGIN
                            SET @gEquipPostPeriod = @gCurrentPeriod
                         END
                      ELSE
                         BEGIN
                            SET @gEquipPostPeriod = @EquipthePeriod
                         END
                      /*************** End of Posting Period  ***************/     
                      INSERT INTO #Equip_Wrk (DocNbr, LineNbr, EquipAmt, gPostPeriod, Cpny_chrg, Cpny_eq_home, EquipID, Project, GL_Subacct, Equip_Home_Subacct)
                      VALUES(@DocNbrLine, @LineNbr, @EquipAmt, @gEquipPostPeriod, @Cpny_chrg, @Cpny_eq_home, @EquipID, @Project, @GL_Subacct, @Equip_HomeSubacct)
                   END   
             END    --IF RTRIM(@EquipID) <> ''
     
          UPDATE PJTIMDET
             SET PJTIMDET.tl_status = 'P', PJTIMDET.lupd_datetime = GETDATE(), PJTIMDET.lupd_prog = @ProgID, PJTIMDET.lupd_user = @SolUser,
                 PJTIMDET.labor_rate = CASE WHEN @PayType = 'HR' THEN @Update_LaborRate ELSE PJTIMDET.labor_rate END
           WHERE PJTIMDET.docnbr = @DocNbr 
             AND PJTIMDET.linenbr = @LineNbr
             AND PJTIMDET.tl_status <> 'P'
          If @@ERROR <> 0
             BEGIN
                CLOSE PJTimDet_Csr
                DEALLOCATE PJTimDet_Csr
                SET @MsgID = 198
                SET @MsgParms = ''
                SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
                SET @MsgTableID = 'PJTIMDET'
                GOTO ABORT
             END                
          
       -- get next record, if any, and loop.
       FETCH PJTimDet_Csr INTO @DocNbrLine, @LineNbr, @Employee, @RegHours, @OT1Hours, @OT2Hours, @FlatAmtTL18, @TLDate, @CpnyIDHome, 
                               @tl_status, @EquipID, @EquipAmt, @Cpny_chrg, @Cpny_eq_home, @Project, @GL_Subacct, @Equip_HomeSubacct, @GL_Acct, @Task, 
                               @Shift, @Cert_Pay_SW, @Labor_Class_CD, @Group_Code, @Union_CD, @TL_ID16, @Labor_Rate, @Work_Type 
       IF @@ERROR <> 0
          BEGIN
             CLOSE PJTimDet_Csr
             DEALLOCATE PJTimDet_Csr
             SET @MsgID = 199
             SET @MsgParms = ''
             SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
             SET @MsgTableID = 'PJTIMDET'
             GOTO ABORT
          END
    END   -- END of WHILE @@FETCH_STATUS = 0 for PJREVCAT
   
 CLOSE PJTimDet_Csr
 DEALLOCATE PJTimDet_Csr  

 IF (SELECT COUNT(*) FROM PJUOPDET WITH(NOLOCK) WHERE docnbr = @DocNbr) > 0 
    BEGIN
       --Units of Production
       EXEC pp_UnitsOfProductionTimesheets @DocNbr, @SolUser, @ProgID, @gUZActive, @PPResult OUTPUT, @PPUOPLineNbr OUTPUT, @ErrTable OUTPUT  
       IF @PPResult <> 0
          BEGIN
             --800, 817, 820, 825, 830, 840, 850, 860, 870, 1002, 1102, 1202, 1302, 2002, 2102, 2202, 2302, 2402, 2502, 2602, 2702, 2802, 1789
             SET @MsgID = @PPResult
             SET @MsgParms = ''
             SET @MsgLineNbr = @PPUOPLineNbr
             SET @MsgTableID = @ErrTable
             GOTO ABORT
          END
    END


/** Handling Batch and GLTrans from here instead of pp_EquipmentTimesheets so Batch Record isn't locked long **/
 IF @EqipmentTotal > 0 
    BEGIN
      --CREATE BATCH NUMBER
      SELECT  @BatNbr = lastused_1
        FROM  PJDOCNUM
       WHERE ID = '1'
      
      SET @BatNbrLen = LEN(@BatNbr)
      If @BatNbrLen = 0
         SET @BatNbrLen = 10  
       
       
      SET @NewBatNbr = CAST(@Batnbr AS BIGINT) + 1
      SET @BatNbr = RIGHT('0000000000' + CAST(@NewBatnbr AS VARCHAR(10)),@BatNbrLen)
      
      UPDATE PJDOCNUM SET lastused_1 = @BatNbr WHERE ID = '1'
      
      IF (SELECT COUNT(*) FROM BATCH WITH(NOLOCK) WHERE  Batnbr = @BatNbr AND Module = 'TM') > 0
         BEGIN
            -- 0092 Unable to create a GL Batch
            SET @MsgID = 900
            SET @MsgParms = ''
            SET @MsgLineNbr = ''
            SET @MsgTableID = 'PJDOCNUM'
            GOTO ABORT
         END
            
      SET @gGLTranLinenbr = -32768
      
      DECLARE Equipment_Csr INSENSITIVE CURSOR FOR
       SELECT  DocNbr, LineNbr, EquipAmt, gPostPeriod, Cpny_chrg, Cpny_eq_home, EquipID, Project, GL_Subacct, Equip_Home_Subacct  
         FROM #Equip_Wrk p
        ORDER BY p.docnbr,p.linenbr

      OPEN Equipment_Csr
      FETCH Equipment_Csr INTO @Equip_DocNbr, @Equip_LineNbr, @Equip_EquipAmt, @Equip_PostPeriod, @Equip_Cpny_chrg, @Equip_Cpny_eq_home,   
                               @Equip_EquipID, @Equip_Project, @Equip_GLSubAcct, @Equip_EquipHomeSubAcct
      IF @@ERROR <> 0
         BEGIN
            CLOSE Equipment_Csr
            DEALLOCATE Equipment_Csr
            SET @MsgID = 910
            SET @MsgParms = ''
            SET @MsgLineNbr = CAST(@Equip_LineNbr AS VARCHAR(11))
            SET @MsgTableID = 'Equip_Wrk'
           GOTO ABORT
         END  
               
      WHILE @@FETCH_STATUS = 0
         BEGIN
           IF @Equip_EquipAmt <> 0 
              BEGIN
                 --CREATE BATCH RECORD FOR FIRST RECORD IN WRK TABLE.
                 IF @gGLTranLinenbr = -32768
                    BEGIN
                       INSERT Batch (Acct, AutoRev, AutoRevCopy, BalanceType, BankAcct, 
                                     BankSub, BaseCuryID, BatNbr, BatType, clearamt, 
                                     Cleared, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, 
                                     CrTot, CtrlTot, CuryCrTot, CuryCtrlTot, CuryDepositAmt, 
                                     CuryDrTot, CuryEffDate, CuryId, CuryMultDiv, CuryRate, 
                                     CuryRateType, Cycle, DateClr, DateEnt, DepositAmt, 
                                     Descr, DrTot, EditScrnNbr, GLPostOpt, JrnlType, 
                                     LedgerID, LUpd_DateTime, LUpd_Prog, LUpd_User, Module, 
                                     NbrCycle, NoteID, OrigBatNbr, OrigCpnyID, OrigScrnNbr, 
                                     PerEnt, PerPost, Rlsed, S4Future01, S4Future02, 
                                     S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, 
                                     S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, 
                                     Status, Sub, User1, User2, User3, 
                                     User4, User5, User6, User7, User8, 
                                     VOBatNbrForPP)
                       SELECT '', 0, 0, 'A', '', 
                              '', @BaseCuryID, @BatNbr, 'N', 0, 
                              0, h.cpnyId, GETDATE(), @ProgID, @SolUser, 
                              t.equip_amt, t.equip_amt, t.equip_amt, t.equip_amt, 0, 
                              t.equip_amt, CAST(0x00000000 AS SmallDateTime), @BaseCuryID, 'M', 1, 
                              '', 0, CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 0, 
                              '', t.equip_amt, 'TMPTE', 'D', 'EQ', 
                              @LedgerID, GETDATE(), @ProgID, @SolUser, 'TM', 
                              0, 0, '', '', '', 
                              @Equip_PostPeriod, @Equip_PostPeriod, 1, '', '', 
                              0, 0, 0, 0, CAST(0x00000000 AS SmallDateTime), 
                              CAST(0x00000000 AS SmallDateTime), 0, 0, '', '', 
                              'H', '', '', '', 0, 
                              2, '', '', CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 
                              ''
                         FROM PJTIMDET t JOIN PJTIMHDR h 
                                                        ON t.DocNbr = h.DocNbr
                        WHERE t.DocNbr = @Equip_DocNbr
                          AND t.LineNbr = @Equip_LineNbr
                       IF @@ERROR <> 0
                          BEGIN
                             CLOSE Equipment_Csr
                             DEALLOCATE Equipment_Csr
                             SET @MsgID = 920
                             SET @MsgParms = ''
                             SET @MsgLineNbr = CAST(@Equip_LineNbr AS VARCHAR(11))
                             SET @MsgTableID = 'BATCH'
                             GOTO ABORT
                          END  
                    END
                    
                 SET @gGLTranLinenbr = @gGLTranLinenbr + 1
                 
                 EXEC pp_PostEquipmentGLTrans @Equip_DocNbr, @Equip_LineNbr, @Equip_Cpny_chrg, @Equip_Project, 
                                         @gEQ_Charge_GLAcct, @Equip_GLSubAcct, @Equip_EquipAmt, @BatNbr,     
                                         @gGLTranLinenbr, @Equip_PostPeriod, @SolUser, @ProgID,                                              
                                         @PPResult OUTPUT              
                 IF @PPResult <> 0
                    BEGIN
                       --4000
                       CLOSE Equipment_Csr
                       DEALLOCATE Equipment_Csr
                       SET @MsgID = @PPResult
                       SET @MsgParms = ''
                       SET @MsgLineNbr = CAST(@Equip_LineNbr AS VARCHAR(11))
                       SET @MsgTableID = 'GLTRAN'
                       GOTO ABORT
                    END
                    
                 IF @Equip_EquipAmt < 0
                    BEGIN
                       SET @gCRTotal = ROUND(@gCRTotal + (@Equip_EquipAmt * -1), 2)
                    END
                 ELSE
                    BEGIN
                       SET @gDRTotal = ROUND(@gDRTotal + @Equip_EquipAmt, 2)
                    END                  
                    
                 SET @gGLTranLinenbr = @gGLTranLinenbr + 1
                 SET @GLTranOffsetAmt = @Equip_EquipAmt * -1
                 
                 SELECT @project_costbasis = project_costbasis 
                   FROM PJEQUIP e WITH(NOLOCK) 
                  WHERE e.equip_id = @EquipID
                 
                 EXEC pp_PostEquipmentGLTrans @Equip_DocNbr, @Equip_LineNbr, @Equip_Cpny_eq_home, @project_costbasis,    
                                         @gEQ_Offset_GlAcct, @Equip_EquipHomeSubAcct, @GLTranOffsetAmt, @BatNbr,     
                                         @gGLTranLinenbr, @Equip_PostPeriod, @SolUser, @ProgID,                                              
                                         @PPResult OUTPUT              
                 IF @PPResult <> 0
                    BEGIN
                       --4000
                       CLOSE Equipment_Csr
                       DEALLOCATE Equipment_Csr
                       SET @MsgID = @PPResult + 1    --4001  Add 1
                       SET @MsgParms = ''
                       SET @MsgLineNbr = CAST(@Equip_LineNbr AS VARCHAR(11))
                       SET @MsgTableID = 'GLTRAN'
                       GOTO ABORT
                    END  

                 IF @GLTranOffsetAmt < 0
                    BEGIN
                       SET @gCRTotal = ROUND(@gCRTotal + (@GLTranOffsetAmt * -1), 2)
                    END
                 ELSE
                    BEGIN
                       SET @gDRTotal = ROUND(@gDRTotal + @GLTranOffsetAmt, 2)
                    END                    
                    
                 IF @MCActivated = 1 AND @Equip_Cpny_chrg <> @Equip_Cpny_eq_home 
                    BEGIN

                       SELECT TOP 1 @FromAcct = v.FromAcct, @FromSub = v.FromSub
                         FROM vs_Intercompany v WITH(NOLOCK)
                        WHERE v.FromCompany = @Equip_Cpny_eq_home 
                          AND v.ToCompany = @Equip_Cpny_chrg 
                          AND (v.Module = 'TM' OR v.Module = '**') 
                          AND (v.Screen = 'TMPTA' OR v.Screen = 'ALL')
                        ORDER BY v.screen desc, v.module desc                                       
                        IF @FromAcct is Null OR @FromSub is Null OR @FromAcct = '' or @FromSub = ''
                           BEGIN
                              CLOSE Equipment_Csr
                              DEALLOCATE Equipment_Csr
                              SET @MsgID = 930
                              SET @MsgParms = @Equip_Cpny_eq_home + ' | ' + @Equip_Cpny_chrg
                              SET @MsgLineNbr = CAST(@Equip_LineNbr AS VARCHAR(11))
                              SET @MsgTableID = 'vs_InterCompany'
                              GOTO ABORT
                           END                          
                       
                       SET @gGLTranLinenbr = @gGLTranLinenbr + 1
                                  
                       EXEC pp_PostEquipmentGLTrans @Equip_DocNbr, @Equip_LineNbr, @Equip_Cpny_eq_home, @Equip_Project,    
                                                    @FromAcct, @FromSub, @Equip_EquipAmt, '', @BatNbr, 
                                                    @gGLTranLinenbr, @Equip_PostPeriod, @SolUser, @ProgID,                                              
                                                    @PPResult OUTPUT              
                       IF @PPResult <> 0
                          BEGIN
                             --4000
                             CLOSE Equipment_Csr
                             DEALLOCATE Equipment_Csr
                             SET @MsgID = @PPResult + 2    --4002  Add 2
                             SET @MsgParms = ''
                             SET @MsgLineNbr = CAST(@Equip_LineNbr AS VARCHAR(11))
                             SET @MsgTableID = 'GLTRAN'
                             GOTO ABORT
                          END
                          
                       IF @Equip_EquipAmt < 0
                          BEGIN
                             SET @gCRTotal = ROUND(@gCRTotal + (@Equip_EquipAmt * -1), 2)
                          END
                       ELSE
                          BEGIN
                             SET @gDRTotal = ROUND(@gDRTotal + @Equip_EquipAmt, 2)
                          END                           
                          
                       SET @gGLTranLinenbr = @gGLTranLinenbr + 1
                       SET @GLTranOffsetAmt = @Equip_EquipAmt * -1
                                  
                       EXEC pp_PostEquipmentGLTrans @Equip_DocNbr, @Equip_LineNbr, @Equip_Cpny_chrg, @Equip_Project,    
                                                    @FromAcct, @FromSub, @GLTranOffsetAmt, @BatNbr,    
                                                    @gGLTranLinenbr, @Equip_PostPeriod, @SolUser, @ProgID,                                              
                                                    @PPResult OUTPUT              
                       IF @PPResult <> 0
                          BEGIN
                             -- 4000
                             CLOSE Equipment_Csr
                             DEALLOCATE Equipment_Csr
                             SET @MsgID = @PPResult + 3    --4003  Add 3
                             SET @MsgParms = ''
                             SET @MsgLineNbr = CAST(@Equip_LineNbr AS VARCHAR(11))
                             SET @MsgTableID = 'GLTRAN'
                             GOTO ABORT
                          END                          
                    
                       IF @GLTranOffsetAmt < 0
                          BEGIN
                             SET @gCRTotal = ROUND(@gCRTotal + (@GLTranOffsetAmt * -1), 2)
                          END
                       ELSE
                          BEGIN
                             SET @gDRTotal = ROUND(@gDRTotal + @GLTranOffsetAmt, 2)
                          END                        
                    END                                      
              END
                     
           -- get next record, if any, and loop.
           FETCH Equipment_Csr INTO @Equip_DocNbr, @Equip_LineNbr, @Equip_EquipAmt, @Equip_PostPeriod, @Equip_Cpny_chrg, @Equip_Cpny_eq_home,   
                                    @Equip_EquipID, @Equip_Project, @Equip_GLSubAcct, @Equip_EquipHomeSubAcct   
           IF @@ERROR <> 0
              BEGIN
                 CLOSE Equipment_Csr
                 DEALLOCATE Equipment_Csr
                 SET @MsgID = 950
                 SET @MsgParms = ''
                 SET @MsgLineNbr = ''
                 SET @MsgTableID = 'Equip_Wrk'
                 GOTO ABORT
              END       
         END 
      CLOSE Equipment_Csr
      DEALLOCATE Equipment_Csr
      
      UPDATE BATCH 
         SET status = 'U', CrTot = @gCRTotal, CuryCrTot = @gCRTotal, DrTot = @gDRTotal, CuryDrTot = @gDRTotal, 
             CtrlTot = @gDRTotal, CuryCtrlTot = @gDRTotal, lupd_datetime = GetDate(), LUpd_User = @SolUser
       WHERE batnbr = @BatNbr
         AND module = 'TM'
      IF @@ERROR <> 0
         BEGIN
            SET @MsgID = 960
            SET @MsgParms = LTRIM(RTRIM(@BatNbr))
            SET @MsgLineNbr = ''
            SET @MsgTableID = 'BATCH'
            GOTO ABORT
         END     
    END

 UPDATE PJTIMHDR 
    SET th_status = 'P', lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser
  WHERE PJTIMHDR.docnbr = @DocNbr
 IF @@ERROR <> 0
    BEGIN
       SET @MsgID = 970
       SET @MsgParms = LTRIM(RTRIM(@BatNbr))
       SET @MsgLineNbr = ''
       SET @MsgTableID = 'PJTIMHDR'
       GOTO ABORT
    END 

 COMMIT TRANSACTION

 GOTO FINISH

 ABORT:
 ROLLBACK TRANSACTION

INSERT WrkTimesheetPostBad (DocNbr, LineNbr, MsgId, MsgParms, MsgTable, UserID, UserAddress)
VALUES (@DocNbr, @MsgLineNbr, @MsgID, @MsgParms, @MsgTableID, @UserID, @UserAddress)

 UPDATE PJTIMHDR 
    SET th_status = 'R', lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser
  WHERE PJTIMHDR.docnbr = @DocNbr
  
 FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_Timesheets_PostDirect_AndEquip] TO [MSDSL]
    AS [dbo];

