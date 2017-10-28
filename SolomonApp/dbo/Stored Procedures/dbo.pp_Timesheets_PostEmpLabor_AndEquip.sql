
 CREATE PROCEDURE pp_Timesheets_PostEmpLabor_AndEquip @DocNbr VARCHAR(10), @UserAddress VARCHAR(47), 
                                   @SolUser Varchar(10), @gEnd_Date As SmallDateTime, @HdrTH_Date As SmallDateTime,
                                   @AllowPostingPriorPeriods VARCHAR(1), @ProgID VARCHAR(8), @gUZActive INTEGER, @UserID VARCHAR(47)
AS
--@AllowPostingPriorPeriods 'Y' - Yes  'N' - No
SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

  DECLARE @DayNum Integer
  DECLARE @NewLineNbr Integer
  DECLARE @NewLineNbrPJLABDLY Integer
  DECLARE @UPDATELABDET VARCHAR(8)  --Variable used to determine if we update or insert PLLABDET.
  DECLARE @PPResult INT
  DECLARE @ErrTable VARCHAR(20)
  DECLARE @PPUOPLineNbr VARCHAR(11)
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
 
  --PJCONTRL VARIABLES
  DECLARE @PostTimesheetDirectly VARCHAR(1)
  DECLARE @gPFTOneDay VARCHAR(1)  -- Y is True
  DECLARE @gTmFlex VARCHAR(12) 
  DECLARE @gSiteID VARCHAR(4)
  DECLARE @gFirstDay VARCHAR(3)
  DECLARE @gDailyPosting VARCHAR(1)
  DECLARE @gDailyTimecards VARCHAR(1)
  DECLARE @gEQ_Charge_Acct VARCHAR(16)
  DECLARE @gEQ_Offset_Acct VARCHAR(16)
  DECLARE @gEQ_Charge_GLAcct VARCHAR(10)
  DECLARE @gEQ_Offset_GlAcct VARCHAR(10)
  DECLARE @gUOP_Charge_Acct VARCHAR(16)

  --GLSETUP VARIABLES
  DECLARE @GLSetupID VARCHAR(2)
  DECLARE @BaseCuryID VARCHAR(4)
  DECLARE @LedgerID VARCHAR(10)
  
  --MCSETUP VARIABLES
  DECLARE @MCActivated SmallInt
  
  --Document Number VARIABLES
  DECLARE @lastused_labhdr VARCHAR(10)
  DECLARE @NewTimecardDocNbr BigInt
  DECLARE @OrigTimecardDocNbr BigInt
  DECLARE @NewDocNbr VARCHAR(10)
  
  --PJEMPLOY VARIABLES
  DECLARE @Manager1 VarChar(10)
  DECLARE @Manager2 VarChar(10)
  
  --PJWEEK VARIABLES
  DECLARE @PeriodNum VarChar(6)
  DECLARE @WEDate SmallDateTime
  DECLARE @WeekNum VarChar(2)
  
  --PJLABHDR VARIABLES
  DECLARE @LabHdrStatus VARCHAR(1)
  DECLARE @LabHdrDocNbr VARCHAR(10)
  
  --PJTIMDET VARIABLES 
  DECLARE @TimDetGl_Acct VARCHAR(10)
  DECLARE @TimDetGl_SubAcct VARCHAR(24)
  DECLARE @TimDetLabor_Class_cd VARCHAR(4)
  DECLARE @TimDetWork_Type VARCHAR(2)
  DECLARE @TimDetGroup_Code VARCHAR(2)
  DECLARE @TimDetWork_Comp_cd VARCHAR(6)
  DECLARE @TimDetLabor_Rate AS FLOAT
  DECLARE @TimDetDate SmallDateTime
  DECLARE @TimDetCertPaySW INTEGER
  DECLARE @TimDetTask VARCHAR(32)
  DECLARE @TimDetProject VARCHAR(16)
  DECLARE @TimDetID17BillLabor VARCHAR(4)
  DECLARE @TimDetUser1 VARCHAR(30)
  DECLARE @TimDetUser2 VARCHAR(30)
  DECLARE @TimDetUser3 FLOAT
  DECLARE @TimDetUser4 FLOAT
  DECLARE @TimDetEarnType VARCHAR(10)
  DECLARE @TimDetShift VARCHAR(7)
  DECLARE @TimDetID16Source VARCHAR(10)
  DECLARE @TimDetUnionCd VARCHAR(10)
  DECLARE @TimDetCpnyID_Home VARCHAR(10)
  DECLARE @TimDetCpnyID_Chrg VARCHAR(10)
  DECLARE @TimDetID12 VARCHAR(30)
  DECLARE @TimDetID14 VARCHAR(20)
  DECLARE @TimDetRegHrs FLOAT
  DECLARE @TimDetOT1Hrs FLOAT
  DECLARE @TimDetOT2Hrs FLOAT
  DECLARE @TimDetID18FlatAmt FLOAT
  DECLARE @TimDetLaborAmt FLOAT
  
    --Posting VARIABLES
  DECLARE @gEquipPostPeriod VARCHAR(6)
  DECLARE @EquipMaxWeDate AS SmallDateTime
  DECLARE @EquipthePeriod VARCHAR(6)
  DECLARE @gCurrentPeriod VARCHAR(6)
  
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
 SELECT @PostTimesheetDirectly = SUBSTRING(c.control_data,220,1), @gFirstDay = SUBSTRING(c.control_data,221,3)  
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'SETUP'
  IF @@ERROR <> 0  GOTO FINISH  
  
  --TMSetup - Labor Transactions and Invoice Comments (Daily, Weekly) & Time Detail Require Use of Time Detail.
  SELECT @gDailyPosting = SUBSTRING(c.control_data,3,1), @gDailyTimecards = SUBSTRING(c.control_data,1,1)  
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'SETUP1'  
  IF @@ERROR <> 0  GOTO FINISH
  
 --TMSetup - Project Flex Time 
 SELECT @gPFTOneDay = SUBSTRING(c.control_data,1,1)  
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'PFT'  
  IF @@ERROR <> 0  GOTO FINISH
  
 SELECT  @gSiteID = RTRIM(SUBSTRING(c.Control_data,1,4))
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'SITE' 
  If @gSiteID = '' 
  BEGIN
     SET @gSiteID = '0000'
  END
  
  --TMSetup - Default Timecard Approver (S, M, O) - If O, then Default Approver.
 SELECT @gTmFlex = RTRIM(SUBSTRING(c.control_data,1,12))  
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'FLEX-APPROVAL'    
  IF @gTmFlex = '' 
  BEGIN
     SET @gTmFlex = 'NS'
  END
  
  SELECT @gCurrentPeriod = RTRIM(SUBSTRING(c.control_data,1,6))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'CURRENT-PERIOD'
  IF @@ERROR <> 0  GOTO FINISH

 --Acct categories and GL accts from Foundation Setup screen PA.SET
 SELECT @gEQ_Charge_Acct = RTRIM(SUBSTRING(c.control_data,1,16)), @gEQ_Offset_Acct = RTRIM(SUBSTRING(c.control_data,17,16)),
        @gEQ_Charge_GLAcct = RTRIM(SUBSTRING(c.control_data,33,10)), @gEQ_Offset_GlAcct = RTRIM(SUBSTRING(c.control_data,43,10)),
        @gUOP_Charge_Acct = RTRIM(SUBSTRING(c.control_data,53,16))
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'PA' AND c.control_code = 'TIMESHEET-INFO' 
 IF @@ERROR <> 0  GOTO FINISH  
  
  If @PostTimesheetDirectly = 'Y'
  BEGIN
      --This is only for creating the Timecards.
      Goto FINISH
  END
 
  SELECT TOP 1 @PeriodNum = w.period_num, @WEDate = w.we_date, @WeekNum = w.week_num 
   FROM PJWEEK w WITH(NOLOCK)
  WHERE w.we_date >= @HdrTH_Date
  ORDER BY w.we_date
  IF @@ERROR <> 0  GOTO ABORT  
 
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
 
 SELECT @lastused_labhdr = d.lastused_labhdr
   FROM PJDOCNUM d
  WHERE d.ID = '13' ORDER BY d.ID
    
  SET @NewTimecardDocNbr = CAST(@lastused_labHdr AS Bigint)
  SET @OrigTimecardDocNbr = @NewTimecardDocNbr
  SET @EqipmentTotal = 0
  
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
         @GL_Subacct VARCHAR(24), @Equip_HomeSubacct VARCHAR(24)
         
 DECLARE PJTimDet_Csr INSENSITIVE CURSOR FOR
    SELECT  docnbr, linenbr, employee, reg_hours, ot1_hours, ot2_hours, tl_id18, tl_date, CpnyId_home, 
            tl_status, equip_id, equip_amt, CpnyId_chrg, CpnyId_eq_home, Project, gl_subacct, equip_home_subacct 
      FROM PJTIMDET p
     WHERE p.docnbr = @DocNbr 
     ORDER BY p.docnbr, CASE WHEN p.Employee = 'NONE' THEN 2 ELSE 1 END ASC,p.linenbr

 OPEN PJTimDet_Csr
 FETCH PJTimDet_Csr INTO @DocNbrLine, @LineNbr, @Employee, @RegHours, @OT1Hours, @OT2Hours, @FlatAmtTL18, @TLDate, @CpnyIDHome, 
       @tl_status, @EquipID, @EquipAmt, @Cpny_chrg, @Cpny_eq_home, @Project, @GL_Subacct, @Equip_HomeSubacct 
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
       If @Employee <> 'NONE' AND (@RegHours <> 0 or @OT1Hours <> 0 or @OT2Hours <> 0 OR @FlatAmtTL18 <> 0) AND @tl_status <> 'P'  --Cycling Through Once for Both Equipment and Employee, so Check for Status <> P here for Employee.
          BEGIN
       
             SET @UPDATELABDET = ''
             
             /***********  Post Labor  **********/
             IF (SELECT COUNT(*) FROM PJLABHDR WITH(NOLOCK) WHERE  employee = @Employee and pe_date = @gEnd_Date) > 0
                BEGIN
                --Found PJLABHDR RECORD, so update the record.
                SELECT @LabHdrStatus = le_status, @LabHdrDocNbr = docnbr 
                  FROM PJLABHDR WITH(NOLOCK) 
                 WHERE  employee = @Employee and pe_date = @gEnd_Date
                
                SET @NewDocNbr = @LabHdrDocNbr
                
                IF @LabHdrStatus <> 'I' AND @LabHdrStatus <> 'T' 
                   BEGIN
                      --0412
                      CLOSE PJTimDet_Csr
                      DEALLOCATE PJTimDet_Csr
                      SET @MsgID = 105
                      SET @MsgLineNbr = CAST(@LineNbr AS VARCHAR(11))
                      SET @MsgParms = RTRIM(LTRIM(@Employee))
                      SET @MsgTableID = 'PJLABHDR'
                      GOTO ABORT                
                   END
                
                UPDATE PJLABHDR 
                   SET le_id06 = ROUND(CONVERT(DEC(28,3),le_id06) + CONVERT(DEC(28,3),@RegHours) + CONVERT(DEC(28,3),@OT1Hours) + CONVERT(DEC(28,3),@OT2Hours),2),
                       lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser
                 WHERE docnbr = @LabHdrDocNbr
                
                SELECT @TimDetGl_Acct = t.gl_acct, @TimDetGl_SubAcct = t.gl_subacct, @TimDetLabor_Class_cd = t.Labor_Class_Cd,
                       @TimDetWork_Type = t.work_type, @TimDetGroup_Code = t.group_code, @TimDetWork_Comp_cd = t.work_comp_cd,
                       @TimDetLabor_Rate = t.labor_rate, @TimDetDate = t.tl_date, @TimDetCertPaySW = CASE t.cert_pay_sw WHEN 'Y' THEN 1 ELSE 0 END,
                       @TimDetTask = t.pjt_entity, @TimDetProject = t.project, @TimDetID17BillLabor = LEFT(t.tl_id17, 1),
                       @TimDetUser1 = t.user1, @TimDetUser2 = t.user2, @TimDetUser3 = t.user3, @TimDetUser4 = t.user4, 
                       @TimDetEarnType = t.earn_type_id, @TimDetShift = t.shift, @TimDetID16Source = t.tl_id16,
                       @TimDetUnionCd = t.union_cd, @TimDetCpnyID_Home = t.CpnyId_home, @TimDetCpnyID_Chrg = t.CpnyId_chrg,
                       @TimDetID12 = t.tl_id12, @TimDetID14 = t.tl_id14, @TimDetID18FlatAmt = t.tl_id18,
                       @TimDetRegHrs = t.reg_hours, @TimDetOT1Hrs = t.ot1_hours, @TimDetOT2Hrs = t.ot2_hours, @TimDetLaborAmt = t.labor_amt
                  FROM PJTIMDET t	
                 WHERE t.docnbr = @DocNbr
                   AND t.linenbr = @LineNbr
                IF @@ERROR <> 0
                   BEGIN
                      CLOSE PJTimDet_Csr
                      DEALLOCATE PJTimDet_Csr
                      SET @MsgID = 115
                      SET @MsgLineNbr = CAST(@LineNbr AS VARCHAR(11))
                      SET @MsgParms = RTRIM(LTRIM(@Employee))
                      SET @MsgTableID = 'PJTIMDET'
                      GOTO ABORT                
                   END
                   
                IF (SELECT COUNT(*) 
                    FROM PJLABDET l WITH(NOLOCK)
                   WHERE l.docnbr = @LabHdrDocNbr AND l.gl_acct = @TimDetGl_Acct AND l.gl_subacct = @TimDetGl_SubAcct
                     AND l.labor_class_cd = @TimDetLabor_Class_cd AND l.work_type = @TimDetWork_Type AND l.ld_id03 = @TimDetGroup_Code
                     AND l.work_comp_cd = @TimDetWork_Comp_cd AND l.ld_id06 = @TimDetLabor_Rate AND l.ld_id08 = @TimDetDate
                     AND l.ld_id10 = @TimDetCertPaySW AND l.pjt_entity = @TimDetTask AND l.project = @TimDetProject
                     AND l.ld_status = @TimDetID17BillLabor AND l.user1 = @TimDetUser1 AND l.user2 = @TimDetUser2
                     AND l.user3 = @TimDetUser3 AND l.user4 = @TimDetUser4 AND l.earn_type_id = @TimDetEarnType
                     AND l.shift = @TimDetShift AND l.rate_source = @TimDetID16Source AND l.union_cd = @TimDetUnionCd
                     AND l.CpnyId_home = @TimDetCpnyID_Home AND l.CpnyId_chrg = @TimDetCpnyID_Chrg AND l.ld_id12 = @TimDetID12
                     AND l.ld_id14 = @TimDetID14) > 0
                    BEGIN
                      SET @UPDATELABDET = 'YESDATE'
                    END
                 ELSE
                    BEGIN
                       IF (SELECT COUNT(*) 
                             FROM PJLABDET l WITH(NOLOCK)
                            WHERE l.docnbr = @LabHdrDocNbr AND l.gl_acct = @TimDetGl_Acct AND l.gl_subacct = @TimDetGl_SubAcct
                              AND l.labor_class_cd = @TimDetLabor_Class_cd AND l.work_type = @TimDetWork_Type AND l.ld_id03 = @TimDetGroup_Code
                              AND l.work_comp_cd = @TimDetWork_Comp_cd AND l.ld_id06 = @TimDetLabor_Rate AND l.ld_id08 = CAST(0x00000000 AS SmallDateTime)
                              AND l.ld_id10 = @TimDetCertPaySW AND l.pjt_entity = @TimDetTask AND l.project = @TimDetProject
                              AND l.ld_status = @TimDetID17BillLabor AND l.user1 = @TimDetUser1 AND l.user2 = @TimDetUser2
                              AND l.user3 = @TimDetUser3 AND l.user4 = @TimDetUser4 AND l.earn_type_id = @TimDetEarnType
                              AND l.shift = @TimDetShift AND l.rate_source = @TimDetID16Source AND l.union_cd = @TimDetUnionCd
                              AND l.CpnyId_home = @TimDetCpnyID_Home AND l.CpnyId_chrg = @TimDetCpnyID_Chrg AND l.ld_id12 = @TimDetID12
                              AND l.ld_id14 = @TimDetID14) > 0 
                       BEGIN
                          SET @UPDATELABDET = 'YESNODATE'
                       END                         
                    END                    
                   
                If @UPDATELABDET <> ''
                   BEGIN
                      IF @gPFTOneDay = 'Y'
                         BEGIN
                            SET @DayNum = 2
                         END
                      ELSE
                         BEGIN     
                            SET @DayNum = datepart (dw, @TLDate) 
                            SET @DayNum = CASE @gFirstDay WHEN 'Mon' THEN @DayNum
                                                          WHEN 'Tue' THEN @DayNum + 6
                                                          WHEN 'Wed' THEN @DayNum + 5
                                                          WHEN 'Thu' THEN @DayNum + 4
                                                          WHEN 'Fri' THEN @DayNum + 3
                                                          WHEN 'Sat' THEN @DayNum + 2
                                                          WHEN 'Sun' THEN @DayNum + 1 END		            
                            If @DayNum > 7  
                               BEGIN 
                                  SET @DayNum = @DayNum - 7
                               END
                         END                   
                      
                      UPDATE l 
                         SET l.day1_hr1 = CASE @gPFTOneDay WHEN 'Y' 
                                                           THEN ROUND(CONVERT(DEC(28,3),day1_hr1) + CONVERT(DEC(28,3),day2_hr1) + CONVERT(DEC(28,3),day3_hr1) +
                                                                  CONVERT(DEC(28,3),day4_hr1) + CONVERT(DEC(28,3),day5_hr1) + CONVERT(DEC(28,3),day6_hr1) +
                                                                  CONVERT(DEC(28,3),day7_hr1),2) 
                                                           ELSE CASE @DayNum WHEN 2
                                                                             THEN ROUND(CONVERT(DEC(28,3),day1_hr1) + CONVERT(DEC(28,3),@TimDetRegHrs),2) 
                                                                             ELSE day1_hr1 END END, 
                             l.day1_hr2 = CASE @gPFTOneDay WHEN 'Y' 
                                                           THEN ROUND(CONVERT(DEC(28,3),day1_hr2) + CONVERT(DEC(28,3),day2_hr2) + CONVERT(DEC(28,3),day3_hr2) +
                                                                  CONVERT(DEC(28,3),day4_hr2) + CONVERT(DEC(28,3),day5_hr2) + CONVERT(DEC(28,3),day6_hr2) +
                                                                  CONVERT(DEC(28,3),day7_hr2),2) 
                                                           ELSE CASE @DayNum WHEN 2
                                                                             THEN ROUND(CONVERT(DEC(28,3),day1_hr2) + CONVERT(DEC(28,3),@TimDetOT1Hrs),2) 
                                                                             ELSE day1_hr2 END END,                                                           
                             l.day1_hr3 = CASE @gPFTOneDay WHEN 'Y' 
                                                           THEN ROUND(CONVERT(DEC(28,3),day1_hr3) + CONVERT(DEC(28,3),day2_hr3) + CONVERT(DEC(28,3),day3_hr3) +
                                                                  CONVERT(DEC(28,3),day4_hr3) + CONVERT(DEC(28,3),day5_hr3) + CONVERT(DEC(28,3),day6_hr3) +
                                                                  CONVERT(DEC(28,3),day7_hr3),2) 
                                                           ELSE CASE @DayNum WHEN 2
                                                                             THEN ROUND(CONVERT(DEC(28,3),day1_hr3) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2) 
                                                                             ELSE day1_hr3 END END,
                             l.day2_hr1 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 3 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day2_hr1) + CONVERT(DEC(28,3),@TimDetRegHrs),2) 
                                                                                      ELSE l.day2_hr1 END END,
                             l.day3_hr1 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 4 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day3_hr1) + CONVERT(DEC(28,3),@TimDetRegHrs),2) 
                                                                                      ELSE l.day3_hr1 END END,
                             l.day4_hr1 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 5 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day4_hr1) + CONVERT(DEC(28,3),@TimDetRegHrs),2) 
                                                                                      ELSE l.day4_hr1 END END,                                                                                                                                                                                                                                                               
                             l.day5_hr1 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 6 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day5_hr1) + CONVERT(DEC(28,3),@TimDetRegHrs),2) 
                                                                                      ELSE l.day5_hr1 END END, 
                             l.day6_hr1 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 7 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day6_hr1) + CONVERT(DEC(28,3),@TimDetRegHrs),2) 
                                                                                      ELSE l.day6_hr1 END END, 
                             l.day7_hr1 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 1 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day7_hr1) + CONVERT(DEC(28,3),@TimDetRegHrs),2) 
                                                                                      ELSE l.day7_hr1 END END,
                                                                                                                                                          
                             l.day2_hr2 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 3 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day2_hr2) + CONVERT(DEC(28,3),@TimDetOT1Hrs),2) 
                                                                                      ELSE l.day2_hr2 END END,  
                             l.day3_hr2 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 4 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day3_hr2) + CONVERT(DEC(28,3),@TimDetOT1Hrs),2) 
                                                                                      ELSE l.day3_hr2 END END, 
                             l.day4_hr2 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 5 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day4_hr2) + CONVERT(DEC(28,3),@TimDetOT1Hrs),2) 
                                                                                      ELSE l.day4_hr2 END END, 
                             l.day5_hr2 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 6 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day5_hr2) + CONVERT(DEC(28,3),@TimDetOT1Hrs),2) 
                                                                                      ELSE l.day5_hr2 END END,  
                             l.day6_hr2 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 7 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day6_hr2) + CONVERT(DEC(28,3),@TimDetOT1Hrs),2) 
                                                                                      ELSE l.day6_hr2 END END,  
                             l.day7_hr2 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 1 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day7_hr2) + CONVERT(DEC(28,3),@TimDetOT1Hrs),2) 
                                                                                      ELSE l.day7_hr2 END END,        
                                                                                                                                                  
                             l.day2_hr3 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 3 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day2_hr3) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2) 
                                                                                      ELSE l.day2_hr3 END END,  
                             l.day3_hr3 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 4 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day3_hr3) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2) 
                                                                                      ELSE l.day3_hr3 END END,  
                             l.day4_hr3 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 5 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day4_hr3) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2) 
                                                                                      ELSE l.day4_hr3 END END,  
                             l.day5_hr3 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 6 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day5_hr3) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2) 
                                                                                      ELSE l.day5_hr3 END END,  
                             l.day6_hr3 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 7 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day6_hr3) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2) 
                                                                                      ELSE l.day6_hr3 END END,  
                             l.day7_hr3 = CASE @gPFTOneDay WHEN 'Y' THEN 0
                                                                    ELSE CASE @DayNum WHEN 1 
                                                                                      THEN ROUND(CONVERT(DEC(28,3),day7_hr3) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2) 
                                                                                      ELSE l.day7_hr3 END END,
                             l.total_hrs = ROUND(CONVERT(DEC(28,3),l.total_hrs) + CONVERT(DEC(28,3),@TimDetRegHrs) +  
                                                 CONVERT(DEC(28,3),@TimDetOT1Hrs) + CONVERT(DEC(28,3),@TimDetOT2Hrs),2),
                             l.ld_id07 = ROUND(CONVERT(DEC(28,3),l.ld_id07) + CONVERT(DEC(28,3),@TimDetID18FlatAmt),2),
                             l.total_amount = ROUND(CONVERT(DEC(28,3),l.total_amount) + CONVERT(DEC(28,3),@TimDetLaborAmt),2),
                             l.lupd_datetime = GETDATE(), l.lupd_prog = @ProgID, l.lupd_user = @SolUser                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                        FROM PJLABDET l 
                       WHERE l.docnbr = @LabHdrDocNbr AND l.gl_acct = @TimDetGl_Acct AND l.gl_subacct = @TimDetGl_SubAcct
                         AND l.labor_class_cd = @TimDetLabor_Class_cd AND l.work_type = @TimDetWork_Type AND l.ld_id03 = @TimDetGroup_Code
                         AND l.work_comp_cd = @TimDetWork_Comp_cd AND l.ld_id06 = @TimDetLabor_Rate 
                         AND l.ld_id10 = @TimDetCertPaySW AND l.pjt_entity = @TimDetTask AND l.project = @TimDetProject
                         AND l.ld_status = @TimDetID17BillLabor AND l.user1 = @TimDetUser1 AND l.user2 = @TimDetUser2
                         AND l.user3 = @TimDetUser3 AND l.user4 = @TimDetUser4 AND l.earn_type_id = @TimDetEarnType
                         AND l.shift = @TimDetShift AND l.rate_source = @TimDetID16Source AND l.union_cd = @TimDetUnionCd
                         AND l.CpnyId_home = @TimDetCpnyID_Home AND l.CpnyId_chrg = @TimDetCpnyID_Chrg AND l.ld_id12 = @TimDetID12
                         AND l.ld_id14 = @TimDetID14                 
                         AND (l.ld_id08 = @TimDetDate OR (l.ld_id08 = CAST(0x00000000 AS SmallDateTime) AND @UPDATELABDET = 'YESNODATE'))
                      IF @@ERROR <> 0
                         BEGIN
                            CLOSE PJTimDet_Csr
                            DEALLOCATE PJTimDet_Csr
                            SET @MsgID = 125
                            SET @MsgLineNbr = CAST(@LineNbr AS VARCHAR(11))
                            SET @MsgParms = RTRIM(LTRIM(@LabHdrDocNbr))
                            SET @MsgTableID = 'PJLABDET'
                            GOTO ABORT   
                         END
                   END                 --If @UPDATELABDET <> ''                  
              END
           ELSE  --PJLABHDR record does not exist
                BEGIN 
                   SET @NewTimecardDocNbr = @NewTimecardDocNbr + 1  --Increment to Last Document Number.
                   SET @NewDocNbr = RIGHT('0000000000' + CAST(@NewTimecardDocNbr AS VARCHAR(10)),10)
               
                   SELECT @Manager1 = p.manager1, @Manager2 = p.manager2
                     FROM PJEMPLOY p WITH(NOLOCK)
                    WHERE p.employee = @Employee
               
                   INSERT PJLABHDR(Approver, 
                                   BaseCuryId, CpnyId_home, crtd_datetime, crtd_prog, 
                                   crtd_user, CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType, 
                                   docnbr, employee, fiscalno, le_id01, 
                                   le_id02, le_id03, le_id04, le_id05, 
                                   le_id06, 
                                   le_id07, le_id08, le_id09, le_id10, le_key, 
                                   le_status, le_type, lupd_datetime, lupd_prog, lupd_user, 
                                   noteid, period_num, pe_date, user1, user2, 
                                   user3, user4, week_num)
                   VALUES (CASE SUBSTRING(@gTmFlex,2,1) WHEN 'M' THEN @Manager2
                                                        WHEN 'O' THEN SUBSTRING(@gTmFlex, 3,10)
                                                        ELSE @Manager1 END, 
                           @BaseCuryId, @CpnyIDHome, GETDATE(), @ProgID, 
                           @SolUser, CAST(0x00000000 AS SmallDateTime), @BaseCuryId, 'M', 1, '', 
                           @NewDocNbr, @Employee, '', CASE WHEN @gPFTOneDay = 'Y' THEN 'Y' ELSE '' END, 
                           '', '', '', @gSiteID,  
                           ROUND(CONVERT(DEC(28,3),@RegHours) +  CONVERT(DEC(28,3),@OT1Hours) + CONVERT(DEC(28,3),@OT2Hours),2), 
                           0, CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 1, '', 
                           'T', 'R', GETDATE(), @ProgID, @SolUser, 
                           0, @PeriodNum, @WEDate, '', '', 
                           0, 0, @WeekNum)
                   If @@ERROR <> 0
                      BEGIN
                         CLOSE PJTimDet_Csr
                         DEALLOCATE PJTimDet_Csr
                         SET @MsgID = 130
                         SET @MsgLineNbr = CAST(@LineNbr AS VARCHAR(11))
                         SET @MsgParms = ''
                         SET @MsgTableID = 'PJLABHDR'
		                 GOTO ABORT
		              END
                END                     --IF (SELECT COUNT(*) FROM PJLABHDR WITH(NOLOCK) WHERE  employee = @Employee and pe_date = @gEnd_Date) > 0   
            
            		       
             IF @gPFTOneDay = 'Y'
                BEGIN
                   SET @DayNum = 2
                END
             ELSE
                BEGIN     
                   SET @DayNum = datepart (dw, @TLDate) 
                   SET @DayNum = CASE @gFirstDay WHEN 'Mon' THEN @DayNum
                                                 WHEN 'Tue' THEN @DayNum + 6
                                                 WHEN 'Wed' THEN @DayNum + 5
                                                 WHEN 'Thu' THEN @DayNum + 4
                                                 WHEN 'Fri' THEN @DayNum + 3
                                                 WHEN 'Sat' THEN @DayNum + 2
                                                 WHEN 'Sun' THEN @DayNum + 1 END		            
                   If @DayNum > 7  
                   BEGIN 
                      SET @DayNum = @DayNum - 7
                   END
                END                              --IF @gPFTOneDay = 'Y' 	       
	            
             IF (SELECT COUNT(*) FROM PJLABDET WITH(NOLOCK) WHERE  docnbr = @NewDocNbr) > 0
                BEGIN
                   SELECT @NewLineNbr = MAX(linenbr) from PJLABDET WITH(NOLOCK) WHERE docnbr = @NewDocNbr
                END
             ELSE
                BEGIN
                   SET @NewLineNbr = -32800
                END       
		     
		     If @UPDATELABDET = ''       
	 	        BEGIN
	 	           INSERT PJLABDET (CpnyId_chrg, CpnyId_home, crtd_datetime, crtd_prog, crtd_user, 
                                    day1_hr1, day1_hr2, day1_hr3, day2_hr1, day2_hr2, 
                                    day2_hr3, day3_hr1, day3_hr2, day3_hr3, day4_hr1, 
                                    day4_hr2, day4_hr3, day5_hr1, day5_hr2, day5_hr3, 
                                    day6_hr1, day6_hr2, day6_hr3, day7_hr1, day7_hr2, 
                                    day7_hr3, docnbr, earn_type_id, gl_acct, gl_subacct, 
                                    labor_class_cd, labor_stdcost, ld_desc, ld_id01, ld_id02, 
                                    ld_id03, ld_id04, ld_id05, ld_id06, ld_id07, 
                                    ld_id08, ld_id09, ld_id10, ld_id11, ld_id12, 
                                    ld_id13, ld_id14, ld_id15, ld_id16, ld_id17, 
                                    ld_id18, ld_id19, ld_id20, ld_status, linenbr, 
                                    lupd_datetime, lupd_prog, lupd_user, noteid, pjt_entity, 
                                    project, rate_source, shift, SubTask_Name, SubTask_UID, 
                                    total_amount, total_hrs, 
                                    union_cd, user1, user2, 
                                    user3, user4, work_comp_cd, work_type)
                   SELECT t.CpnyId_chrg, t.CpnyId_home, GETDATE(), @ProgID, @SolUser, 
                          day1_hr1 = CASE @DayNum WHEN 2 THEN t.reg_hours ELSE 0 END, day1_hr2 = CASE @DayNum WHEN 2 THEN t.ot1_hours ELSE 0 END, 
                          day1_hr3 = CASE @DayNum WHEN 2 THEN t.ot2_hours ELSE 0 END, 
                          day2_hr1 = CASE @DayNum WHEN 3 THEN t.reg_hours ELSE 0 END, day2_hr2 = CASE @DayNum WHEN 3 THEN t.ot1_hours ELSE 0 END, 
                          day2_hr3 = CASE @DayNum WHEN 3 THEN t.ot2_hours ELSE 0 END,
                          day3_hr1 = CASE @DayNum WHEN 4 THEN t.reg_hours ELSE 0 END, day3_hr2 = CASE @DayNum WHEN 4 THEN t.ot1_hours ELSE 0 END, 
                          day3_hr3 = CASE @DayNum WHEN 4 THEN t.ot2_hours ELSE 0 END, 
                          day4_hr1 = CASE @DayNum WHEN 5 THEN t.reg_hours ELSE 0 END, day4_hr2 = CASE @DayNum WHEN 5 THEN t.ot1_hours ELSE 0 END, 
                          day4_hr3 = CASE @DayNum WHEN 5 THEN t.ot2_hours ELSE 0 END, 
                          day5_hr1 = CASE @DayNum WHEN 6 THEN t.reg_hours ELSE 0 END, day5_hr2 = CASE @DayNum WHEN 6 THEN t.ot1_hours ELSE 0 END, 
                          day5_hr3 = CASE @DayNum WHEN 6 THEN t.ot2_hours ELSE 0 END, 
                          day6_hr1 = CASE @DayNum WHEN 7 THEN t.reg_hours ELSE 0 END, day6_hr2 = CASE @DayNum WHEN 7 THEN t.ot1_hours ELSE 0 END, 
                          day6_hr3 = CASE @DayNum WHEN 7 THEN t.ot2_hours ELSE 0 END, 
                          day7_hr1 = CASE @DayNum WHEN 1 THEN t.reg_hours ELSE 0 END, day7_hr2 = CASE @DayNum WHEN 1 THEN t.ot1_hours ELSE 0 END, 
                          day7_hr3 = CASE @DayNum WHEN 1 THEN t.ot2_hours ELSE 0 END, 
                          @NewDocNbr, t.earn_type_id, t.gl_acct, t.gl_subacct, 
                          t.labor_class_cd, 0, h.th_comment, t.tl_id11, '', 
                          t.group_code, '', @gSiteID, t.labor_rate, t.tl_id18, 
                          t.tl_date, CAST(0x00000000 AS SmallDateTime), CASE t.cert_pay_sw WHEN 'Y' THEN 1 ELSE 0 END, '', t.tl_id12, 
                          '', t.tl_id14, '', '', '', 
                          0, 0, CAST(0x00000000 AS SmallDateTime), t.tl_id17, @NewLineNbr + 32, 
                          GETDATE(), @ProgID, @SolUser, 0, t.pjt_entity, 
                          t.project, LEFT(t.tl_ID16,1), t.shift, t.SubTask_Name, 0, 
                          t.labor_amt, ROUND(CONVERT(DEC(28,3),t.reg_hours) +  CONVERT(DEC(28,3),t.ot1_hours) + CONVERT(DEC(28,3),t.ot2_hours),2),
                          t.union_cd, t.user1, t.user2, 
                          t.user3, t.user4, t.work_comp_cd, t.work_type
                     FROM PJTIMDET t JOIN PJTIMHDR h
                                      ON t.docnbr = h.docnbr
                    WHERE t.docnbr = @DocNbr
                      AND t.linenbr = @LineNbr
                   If @@ERROR <> 0
                      BEGIN
                         CLOSE PJTimDet_Csr
                         DEALLOCATE PJTimDet_Csr
                         SET @MsgID = 135
                         SET @MsgLineNbr = CAST(@LineNbr AS VARCHAR(11))
                         SET @MsgParms = ''
                         SET @MsgTableID = 'PJLABDET'
		                 GOTO ABORT
		              END            
		        END                        --If @UPDATELABDET = ''
		        
             If @gDailyTimecards = 'Y' 
		        BEGIN
                   IF (SELECT COUNT(*) FROM PJLABDLY WITH(NOLOCK) WHERE  docnbr = @NewDocNbr) > 0
                      BEGIN
                         SELECT @NewLineNbrPJLABDLY = MAX(linenbr) from PJLABDLY WHERE docnbr = @NewDocNbr
                      END
                   ELSE
                      BEGIN
                         SET @NewLineNbrPJLABDLY = -32800
                      END  
		        
		        
                   INSERT PJLABDLY (certprflag, crtd_datetime, crtd_prog, crtd_user, 
		                            data1, 
                                    data2, data3, docnbr, error, gl_acct,  
                                    gl_subacct, groupcode, labor_class_cd, ldl_date, 
                                    ldl_day, 
                                    ldl_desc, ldl_edtime, ldl_elptime, ldl_siteid, ldl_sttime, 
                                    ldl_wdhours, ly_id01, 
                                    ly_id02, ly_id03, 
                                    ly_id04, 
                                    ly_id05, ly_id06, ly_id07, ly_id08, ly_id09, 
                                    ly_id10, lineNbr, lupd_datetime, lupd_prog, lupd_user,
                                    NoteId, ovt1_wdhours, ovt2_wdhours, pjt_entity, project,
                                    user1, user2, user3, user4, WorkType)
                   SELECT CASE t.cert_pay_sw WHEN 'Y' THEN 1 ELSE 0 END, GETDATE(), @ProgID, @SolUser, 
                          ROUND(CONVERT(DEC(28,3),t.reg_hours) +  CONVERT(DEC(28,3),t.ot1_hours) + CONVERT(DEC(28,3),t.ot2_hours),2), 
                          t.labor_amt, '', @NewDocNbr, '', t.gl_acct, 
                          t.gl_subacct, t.group_code, t.labor_class_cd, t.tl_date, 
                          CASE datepart (dw, @TLDate) WHEN 1 THEN 'DAY7'
                                                      WHEN 2 THEN 'DAY1'
                                                      WHEN 3 THEN 'DAY2'
                                                      WHEN 4 THEN 'DAY3'
                                                      WHEN 5 THEN 'DAY4'
                                                      WHEN 6 THEN 'DAY5'
                                                      WHEN 7 THEN 'DAY6' END, 
                          '', t.end_time, t.elapsed_time, @gSiteID, t.start_time, 
                          t.reg_hours, '', 
                          '  ' + LEFT(t.earn_type_id + '          ',10) + LEFT(t.tl_id16 + '          ',1) + t.shift, '', 
                          LEFT(t.work_comp_cd + '      ',6) + t.union_cd, 
                          '', t.labor_rate, t.tl_id18, CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 
                          CASE t.tl_id17 WHEN 'N' THEN 1 ELSE 0 END, @NewLineNbrPJLABDLY + 32, GETDATE(), @ProgID, @SolUser, 
                          NoteId, t.ot1_hours, t.ot2_hours, t.pjt_entity, t.project, 
                          t.user1, t.user2, t.user3, t.user4, t.work_type
                     FROM PJTIMDET t	
                    WHERE t.docnbr = @DocNbr
                      AND t.linenbr = @LineNbr
                   If @@ERROR <> 0
                      BEGIN
                         CLOSE PJTimDet_Csr
                         DEALLOCATE PJTimDet_Csr
                         SET @MsgID = 140
                         SET @MsgLineNbr = CAST(@LineNbr AS VARCHAR(11))
                         SET @MsgParms = ''
                         SET @MsgTableID = 'PJLABDLY'
                         GOTO ABORT
                      END                 	        
                END                --If @gDailyPosting = 'Y' 
          END                      --If @Employee <> 'NONE' AND (@RegHours <> 0 or @OT1Hours <> 0 or @OT2Hours <> 0 OR @FlatAmtTL18 <> 0)
     
          IF RTRIM(@EquipID) <> ''
             BEGIN           
             
                EXEC pp_EquipmentTimesheets @DocNbr, @LineNbr, 
                                   @SolUser, @gEnd_Date, @EquipID, 
                                   @HdrTH_Date, @ProgID, @gUZActive,
                                   @AllowPostingPriorPeriods, '', @PPResult OUTPUT, @ErrTable OUTPUT
                IF @PPResult <> 0
                   BEGIN
                      --400, 417, 425, 500, 517, 525, 600, 3000, 3001, 3100, 3101, 3200, 3201, 1000, 1001, 1100, 1101, 1200, 1201, 1300, 1301, 2000, 2001,
                      --2100, 2101, 2200, 2201, 2300, 2301, 2400, 2401, 2500, 2501, 2600, 2601, 2700, 2701, 2800, 2801, 1789
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
             END  
     
          UPDATE PJTIMDET
             SET PJTIMDET.tl_status = 'P', PJTIMDET.lupd_datetime = GETDATE(), PJTIMDET.lupd_prog = @ProgID, PJTIMDET.lupd_user = @SolUser 
           WHERE PJTIMDET.docnbr = @DocNbr 
             AND PJTIMDET.linenbr = @LineNbr
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
                               @tl_status, @EquipID, @EquipAmt, @Cpny_chrg, @Cpny_eq_home, @Project, @GL_Subacct, @Equip_HomeSubacct 
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

 --Update the Table at the End for only the very last Document Number.
 IF @OrigTimecardDocNbr <> @NewTimecardDocNbr 
    BEGIN
       UPDATE PJDOCNUM SET lastused_labhdr = RIGHT('0000000000' + CAST(@NewTimecardDocNbr AS VARCHAR(10)),10)
       WHERE PJDOCNUM.ID = '13' 
       IF @@ERROR <> 0
          BEGIN
             SET @MsgID = 197
             SET @MsgParms = ''
             SET @MsgLineNbr = CAST(@DocNbrLine AS VARCHAR(11))
             SET @MsgTableID = 'PJDOCNUM'
             GOTO ABORT             
          END
    END 

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
            SET @MsgTableID = 'BATCH'
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
                             --4000
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
    ON OBJECT::[dbo].[pp_Timesheets_PostEmpLabor_AndEquip] TO [MSDSL]
    AS [dbo];

