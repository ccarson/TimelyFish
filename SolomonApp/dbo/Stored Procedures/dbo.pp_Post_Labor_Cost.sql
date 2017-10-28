
 CREATE PROCEDURE pp_Post_Labor_Cost @DocNbr VARCHAR(10), @LineNbr SmallInt, @PayType VARCHAR(4), 
                                     @hr_type VARCHAR(3), @wHrs FLOAT, @pHrs FLOAT, @Amt FLOAT,
                                     @Rate_Source VARCHAR(1), @ProgID VARCHAR(8), @SolUser Varchar(10),
                                     @TimDet_GL_Acct VARCHAR(10), @gPostPeriod VARCHAR(6),
                                     @PJPENT_pe_id03 VARCHAR(16), @PJPROJEX_pm_id14 VARCHAR(16),
                                     @gUZActive INTEGER, @Detail_Num INTEGER, @gSiteID VARCHAR(4),
                                     @PPResult INT OUTPUT, @PPResultParms VARCHAR(100) OUTPUT, @PPErrTable VARCHAR(2) OUTPUT                                                                                       
AS
   DECLARE @ERRORNBR INT
   DECLARE @AccountCategory VARCHAR(16)
   DECLARE @gLab_Acct_Cat VARCHAR(16)
   DECLARE @UZPeriod VARCHAR(6)
   
   --PJLABDIS VARIABLES
   DECLARE @PJLABDIS_gl_acct VARCHAR(10)
   DECLARE @PJLABDIS_acct VARCHAR(16)
   DECLARE @PJLABDIS_project VARCHAR(16)
   DECLARE @PJLABDIS_task VARCHAR(32)
   DECLARE @PJLABDIS_pe_date SmallDateTime      
   
   --PJCONTROL
   DECLARE @tmsetup_fringe_gl_acct VARCHAR(10)
   DECLARE @tmsetup_post_ot_flg VARCHAR(1)
   DECLARE @tmsetup_ot1_gl_acct VARCHAR(10)
   DECLARE @tmsetup_ot2_gl_acct VARCHAR(10)
   DECLARE @tmsetup_post_flg VARCHAR(1)
   DECLARE @tmsetup_prem_gl_acct VARCHAR(10)
   DECLARE @gAllocOption VARCHAR(2) 
   DECLARE @MSP_Interface VARCHAR(1) -- Y is True 
   
   --PJTIMDET VARIABLES
   DECLARE @TimDetTask VARCHAR(32)
   DECLARE @TimDetProject VARCHAR(16)
   DECLARE @TimDetEmployee VARCHAR(10)
   DECLARE @TimDetDate SmallDateTime
   DECLARE @TimDetSubTaskName VARCHAR(50)
   DECLARE @TimDetEarnTypeID VARCHAR(10)
   DECLARE @TimDetCertPaySW VARCHAR(1)
   DECLARE @TimDetShift VARCHAR(7)
   DECLARE @TimDetTLDate SMALLDATETIME   
   
   DECLARE @tmsetup_salaried_earnings_type VARCHAR(10)
   DECLARE @tmsetup_hourly_earnings_type VARCHAR(10)
   DECLARE @tmsetup_ot1_earnings_type VARCHAR(10)
   DECLARE @tmsetup_ot2_earnings_type VARCHAR(10)
   DECLARE @tmsetup_cert_hourly_earnings_type VARCHAR(10)
   DECLARE @tmsetup_cert_ot1_earnings_type VARCHAR(10)
   DECLARE @tmsetup_cert_ot2_earnings_type VARCHAR(10)
   DECLARE @tmsetup_cert_fringe_earnings_type VARCHAR(10)
   
   DECLARE @EarnTypeID VARCHAR(10)
   DECLARE @PJTRAN_TR_ID24 VARCHAR(20)
   
   --GLSETUP VARIABLES
   DECLARE @GLSetupID VARCHAR(2)
   DECLARE @BaseCuryID VARCHAR(4)
   DECLARE @LedgerID VARCHAR(10)
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
   
   DECLARE @PJPROJEX_work_location VARCHAR(6)
   DECLARE @PJPENTEX_PE_ID13 VARCHAR(6)
   DECLARE @Employee_DfltWrkLoc VARCHAR(6)
   
   SET @PPResultParms = ''   
   SET @PPErrTable = ''
     
  --TMSetup - Labor Transactions and Invoice Comments (Daily, Weekly) & Time Detail Require Use of Time Detail.
  SELECT @tmsetup_salaried_earnings_type = SUBSTRING(c.control_data,62,10),
         @tmsetup_hourly_earnings_type = SUBSTRING(c.control_data,72,10),
         @tmsetup_ot1_earnings_type = SUBSTRING(c.control_data,82,10),
         @tmsetup_ot2_earnings_type = SUBSTRING(c.control_data,92,10),
         @tmsetup_cert_hourly_earnings_type = SUBSTRING(c.control_data,102,10),
         @tmsetup_cert_ot1_earnings_type = SUBSTRING(c.control_data,112,10),
         @tmsetup_cert_ot2_earnings_type = SUBSTRING(c.control_data,122,10),
         @tmsetup_cert_fringe_earnings_type = SUBSTRING(c.control_data,132,10),
         @tmsetup_fringe_gl_acct = SUBSTRING(c.control_data,143,10), 
         @tmsetup_post_ot_flg = SUBSTRING(c.control_data,153,1),
         @tmsetup_ot1_gl_acct = SUBSTRING(c.control_data,154,10), 
         @tmsetup_ot2_gl_acct = SUBSTRING(c.control_data,164,10),
         @tmsetup_post_flg = SUBSTRING(c.control_data,12,1),
         @tmsetup_prem_gl_acct = SUBSTRING(c.control_data,15,10)    
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'TM' AND c.control_code = 'SETUP'  

  SELECT @GLSetupID = SetupId, @BaseCuryID = BaseCuryId, @LedgerID = LedgerID
    FROM GLSetup WITH(NOLOCK) 
   WHERE setupid = 'GL'  
   
  SELECT @BasePrecision = decpl
    FROM Currncy c WITH(NOLOCK) 
   WHERE c.CuryId = @BaseCuryID
  
 -- Allocation posting options
  SELECT @gAllocOption = RTRIM(SUBSTRING(c.control_data,1,2))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'ALLOC-AUTO'

  SELECT @MSP_Interface = RTRIM(SUBSTRING(c.control_data,1,1))
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'MSP-INTERFACE' 
   
  SELECT @TimDetProject = t.project, @TimDetTask = t.pjt_entity, @TimDetEmployee = t.employee, 
         @TimDetSubTaskName = t.SubTask_Name, @TimDetDate = t.tl_date, @TimDetEarnTypeID = t.earn_type_id, 
         @TimDetCertPaySW = t.cert_pay_sw, @TimDetShift = t.shift, @TimDetTLDate = t.tl_date
    FROM PJTIMDET t WITH(NOLOCK)
   WHERE t.docnbr = @DocNbr
     AND t.linenbr = @LineNbr
  IF @@ERROR <> 0
     BEGIN
       SET @ERRORNBR = 200
       SET @PPResultParms = ''
       SET @PPErrTable = 'PJTIMDET'
       GOTO ABORT
    END 
     
  SET @PJLABDIS_project = @TimDetProject
  SET @PJLABDIS_task = @TimDetTask

  EXEC Get_Account_Category @TimDet_GL_Acct, @AccountCategory OUTPUT
  IF @AccountCategory = ''
     BEGIN
        SET @ERRORNBR = 31
        SET @PPResultParms = RTRIM(LTRIM(@TimDet_GL_Acct)) + ' | ' +  RTRIM(LTRIM(@TimDetEmployee))
        SET @PPErrTable = ''
        GOTO ABORT
     END
     
   IF (@wHrs + @pHrs <> 0 OR @Amt <> 0)
      BEGIN       
         IF @hr_type = 'FRG' OR RTRIM(@tmsetup_fringe_gl_acct) = '' 
            BEGIN
               SET @PJLABDIS_gl_acct = @TimDet_GL_Acct
               SET @PJLABDIS_acct = @gLab_Acct_Cat
            END
         ELSE
            BEGIN
               SET @PJLABDIS_gl_acct = @tmsetup_fringe_gl_acct
              
               EXEC Get_Account_Category @PJLABDIS_gl_acct, @AccountCategory OUTPUT
               IF @AccountCategory = ''
                  BEGIN
                     SET @ERRORNBR = 31
                     SET @PPResultParms = RTRIM(LTRIM(@PJLABDIS_gl_acct)) + ' | ' +  RTRIM(LTRIM(@TimDetEmployee))
                     SET @PPErrTable = ''
                     GOTO ABORT
                  END
               SET @PJLABDIS_acct = @AccountCategory
            END     --IF @hr_type = 'FRG' OR RTRIM(@tmsetup_fringe_gl_acct) = ''      
        
         IF @tmsetup_post_ot_flg = 'N' AND LEFT(@Hr_Type,2) = 'OT' AND (@PayType = 'HR' OR @PayType = 'S2') AND @wHrs <> 0
            BEGIN
               IF RTRIM(@Hr_Type) = 'OT1'
                  BEGIN
                     IF RTRIM(@tmsetup_ot1_gl_acct) <> ''
                        BEGIN
                           SET @PJLABDIS_gl_acct = @tmsetup_ot1_gl_acct
                        END
                     ELSE
                        BEGIN
                           SET @PJLABDIS_gl_acct = @TimDet_GL_Acct
                        END
                       
                     EXEC Get_Account_Category @PJLABDIS_gl_acct, @AccountCategory OUTPUT
                     IF @AccountCategory = ''
                        BEGIN
                           SET @ERRORNBR = 31
                           SET @PPResultParms = RTRIM(LTRIM(@PJLABDIS_gl_acct)) + ' | ' +  RTRIM(LTRIM(@TimDetEmployee))
                           SET @PPErrTable = ''
                           GOTO ABORT
                        END
                     SET @PJLABDIS_acct = @AccountCategory
                  END
               ELSE
                  BEGIN
                     IF RTRIM(@tmsetup_ot2_gl_acct) <> ''
                        BEGIN
                           SET @PJLABDIS_gl_acct = @tmsetup_ot2_gl_acct
                        END
                     ELSE
                        BEGIN
                           SET @PJLABDIS_gl_acct = @TimDet_GL_Acct
                        END
                       
                     EXEC Get_Account_Category @PJLABDIS_gl_acct, @AccountCategory OUTPUT
                     IF @AccountCategory = ''
                        BEGIN
                           SET @ERRORNBR = 31
                           SET @PPResultParms = RTRIM(LTRIM(@PJLABDIS_gl_acct)) + ' | ' +  RTRIM(LTRIM(@TimDetEmployee))
                           SET @PPErrTable = ''
                           GOTO ABORT
                        END 
                     SET @PJLABDIS_acct = @AccountCategory
                 
                  END
            END  --IF @tmsetup_post_ot_flg = 'N' AND LEFT(@Hr_Type,2) = 'OT' AND (@PayType = 'HR' OR @PayType = 'S2') AND @wHrs <> 0  
             
         If @tmsetup_post_ot_flg = 'Y' AND LEFT(@Hr_Type,2) = 'OT' AND  @PayType = 'HR' AND @pHrs <> 0
            BEGIN
            
               IF @tmsetup_post_flg = 'N'
                  BEGIN
                     SET @PJLABDIS_project = ''
                     SET @PJLABDIS_task = ''
                  END
                  
               IF RTRIM(@tmsetup_prem_gl_acct) <> ''
                  BEGIN
                     SET @PJLABDIS_gl_acct = @tmsetup_prem_gl_acct
                  END
               ELSE
                  BEGIN
                     SET @PJLABDIS_gl_acct = @TimDet_GL_Acct
                  END
               EXEC Get_Account_Category @PJLABDIS_gl_acct, @AccountCategory OUTPUT
               IF @AccountCategory = ''
                  BEGIN
                    SET @PJLABDIS_acct = @gLab_Acct_Cat 
                  END                  
            END    --If @tmsetup_post_ot_flg = 'Y' AND LEFT(@Hr_Type,2) = 'OT' AND  @PayType = 'HR' AND @pHrs <> 0  
              
         INSERT PJLABDIS(acct, amount, BaseCuryId, CpnyId_chrg, CpnyId_home, 
                         crtd_datetime, crtd_prog, crtd_user, CuryEffDate, CuryId, 
                         CuryMultDiv, CuryRate, CuryRateType, CuryTranamt, Curystdcost, 
                         dl_id01, dl_id02, dl_id03, dl_id04, dl_id05, 
                         dl_id06, dl_id07, dl_id08, dl_id09, dl_id10, 
                         dl_id11, dl_id12, dl_id13, dl_id14, dl_id15, 
                         dl_id16, dl_id17, dl_id18, dl_id19, dl_id20, 
                         docnbr, earn_type_id, employee, fiscalno, gl_acct, 
                         gl_subacct, home_subacct, hrs_type, labor_class_cd, labor_stdcost, 
                         linenbr, lupd_datetime, lupd_prog, lupd_user, pe_date, 
                         pjt_entity, premium_hrs, project, rate_source, shift, 
                         status_1, status_2, status_gl, SubTask_Name, union_cd, 
                         work_comp_cd, work_type, worked_hrs)
         SELECT @PJLABDIS_acct, @Amt, @BaseCuryID, t.CpnyId_chrg, t.CpnyId_home, 
                GETDATE(), @ProgID, @SolUser, CAST(0x00000000 AS SmallDateTime), @BaseCuryID, 
                'M', 1, '', 0, 0, 
                '', '', t.group_code, '', @gSiteID, 
                0, 0, t.tl_date, CAST(0x00000000 AS SmallDateTime), CASE WHEN t.cert_pay_sw = 'Y' THEN 1 ELSE 0 END, 
                '', t.tl_id12, '', t.tl_id14, '', 
                '', '', 0, 0, CAST(0x00000000 AS SmallDateTime), 
                h.docnbr, 
                CASE WHEN RTRIM(t.earn_type_id) <> ''
                       THEN t.earn_type_id
                     ELSE CASE WHEN t.cert_pay_sw = 'Y' AND @PayType = 'HR'
                                 THEN CASE @hr_type WHEN 'REG' THEN @tmsetup_cert_hourly_earnings_type 
                                                    WHEN 'FLT' THEN @tmsetup_cert_hourly_earnings_type
                                                    WHEN 'OT1' THEN @tmsetup_cert_ot1_earnings_type
                                                    WHEN 'OT2' THEN @tmsetup_cert_ot2_earnings_type
                                                    WHEN 'FRG' THEN @tmsetup_cert_fringe_earnings_type
                                                    ELSE '' END
                               ELSE CASE WHEN RTRIM(@PJPENT_pe_id03) <> '' THEN @PJPENT_pe_id03
                                         WHEN RTRIM(@PJPENT_pe_id03) = '' AND RTRIM(@PJPROJEX_pm_id14) <> '' THEN @PJPROJEX_pm_id14
                                         ELSE CASE @PayType WHEN 'HR' THEN CASE @hr_type WHEN 'REG' THEN @tmsetup_hourly_earnings_type
                                                                                         WHEN 'FLT' THEN @tmsetup_hourly_earnings_type
                                                                                         WHEN 'OT1' THEN @tmsetup_ot1_earnings_type
                                                                                         WHEN 'OT2' THEN @tmsetup_ot2_earnings_type
                                                                                         ELSE '' END
                                                            WHEN 'S2' THEN CASE @hr_type WHEN 'REG' THEN @tmsetup_salaried_earnings_type
                                                                                         WHEN 'FLT' THEN @tmsetup_salaried_earnings_type
                                                                                         WHEN 'OT1' THEN @tmsetup_hourly_earnings_type
                                                                                         WHEN 'OT2' THEN @tmsetup_hourly_earnings_type
                                                                                         ELSE '' END                                                            
                                                            ELSE @tmsetup_salaried_earnings_type END END END END, 
                t.employee, @gPostPeriod, @PJLABDIS_gl_acct, 
                t.gl_subacct, t.tl_id11, @hr_type, t.labor_class_cd, 0, 
                t.linenbr, GETDATE(), @ProgID, @SolUser, h.th_date, 
                @PJLABDIS_task, 
                @pHrs, 
                @PJLABDIS_project, 
                @Rate_Source, t.shift, 
                '', CASE WHEN @hr_type = 'FRG' 
                                 THEN 'F' 
                               ELSE CASE WHEN @pHrs <> 0
                                           THEN 'P'
                                         ELSE 'W' END
                           END, 'U', SubTask_Name, t.union_cd, 
                t.work_comp_cd, t.work_type, @wHrs     
           FROM PJTIMDET t WITH(NOLOCK) JOIN PJTIMHDR h WITH(NOLOCK)
                                          ON t.docnbr = h.docnbr
          WHERE t.docnbr = @DocNbr
            AND t.linenbr = @LineNbr                                
        IF @@ERROR <> 0
           BEGIN
              SET @ERRORNBR = 88
              SET @PPResultParms = RTRIM(LTRIM(@DocNbr)) + ' | ' + RTRIM(LTRIM(CAST(@LineNbr AS VARCHAR(8)))) + ' | ' + RTRIM(LTRIM(@hr_type))
              SET @PPErrTable = 'PJLABDIS'
              GOTO ABORT
           END      

   
        If LTRIM(RTRIM(@PJLABDIS_project)) <> ''
           BEGIN
                 
              SET @EarnTypeID = CASE WHEN RTRIM(@TimDetEarnTypeID) <> ''
                                        THEN @TimDetEarnTypeID
                                      ELSE CASE WHEN @TimDetCertPaySW = 'Y' AND @PayType = 'HR'
                                                  THEN CASE @hr_type WHEN 'REG' THEN @tmsetup_cert_hourly_earnings_type 
                                                                     WHEN 'FLT' THEN @tmsetup_cert_hourly_earnings_type
                                                                     WHEN 'OT1' THEN @tmsetup_cert_ot1_earnings_type
                                                                     WHEN 'OT2' THEN @tmsetup_cert_ot2_earnings_type
                                                                     WHEN 'FRG' THEN @tmsetup_cert_fringe_earnings_type
                                                                                ELSE '' END
                                                  ELSE CASE WHEN RTRIM(@PJPENT_pe_id03) <> '' THEN @PJPENT_pe_id03
                                                            WHEN RTRIM(@PJPENT_pe_id03) = '' AND RTRIM(@PJPROJEX_pm_id14) <> '' THEN @PJPROJEX_pm_id14
                                                            ELSE CASE @PayType WHEN 'HR' THEN CASE @hr_type WHEN 'REG' THEN @tmsetup_hourly_earnings_type
                                                                                                            WHEN 'FLT' THEN @tmsetup_hourly_earnings_type
                                                                                                            WHEN 'OT1' THEN @tmsetup_ot1_earnings_type
                                                                                                            WHEN 'OT2' THEN @tmsetup_ot2_earnings_type
                                                                                                                        ELSE '' END
                                                                                WHEN 'S2' THEN CASE @hr_type WHEN 'REG' THEN @tmsetup_salaried_earnings_type
                                                                                                             WHEN 'FLT' THEN @tmsetup_salaried_earnings_type
                                                                                                             WHEN 'OT1' THEN @tmsetup_hourly_earnings_type
                                                                                                             WHEN 'OT2' THEN @tmsetup_hourly_earnings_type
                                                                                                                         ELSE '' END                                                            
                                                                                           ELSE @tmsetup_salaried_earnings_type END END END END
                                                            
              SET @PJTRAN_TR_ID24 = RIGHT('   ' + @hr_type, 3) + RIGHT('       ' + @TimDetShift,7) + RIGHT('          ' + @EarnTypeID, 10)
            
             SELECT @ProjCuryID = PJPROJ.ProjCuryID, @ProjCuryRateType = PJPROJ.ProjCuryRateType,
                    @ProjCuryPrecision = COALESCE(Currncy.DecPl, @BasePrecision)
               FROM PJPROJ WITH(NOLOCK) LEFT JOIN Currncy WITH(NOLOCK) 
                             ON Currncy.CuryId = PJPROJ.ProjCuryId
              WHERE PJPROJ.project = @TimDetProject 
            
             SELECT @PJPROJEX_work_location = work_location 
               FROM PJprojex 
               WHERE project = @TimDetProject  
             IF @PJPROJEX_pm_id14 IS NULL 
                SET @PJPROJEX_pm_id14 = ''
                  
             SELECT @PJPENTEX_PE_ID13 = SUBSTRING(RTRIM(LTRIM(PE_ID13)),1,6)
               FROM PJPENTEX 
              WHERE project =  @TimDetProject AND pjt_entity  =  @TimDetTask  --bPJPENTEX
              IF @PJPENTEX_PE_ID13 IS NULL
                 SET @PJPENTEX_PE_ID13 = ''
               
             SELECT @Employee_DfltWrkLoc = DfltWrkloc FROM Employee WHERE EmpId = @TimDetEmployee  --bEmployee
             IF @Employee_DfltWrkLoc IS NULL
                SET @Employee_DfltWrkLoc = ''
                            
              /*************** Start Get_UZPeriod *******************/
              SET @UZPeriod = ''   
              IF @gUZActive = 1 AND RTRIM(@TimDetEmployee) <> ''
                 BEGIN 
                    EXEC Get_UZPeriod @TimDetProject, @TimDetEmployee, @PJLABDIS_acct, @gPostPeriod, '', @TimDetDate, @UZPeriod OUTPUT
                    IF @@ERROR <> 0
                       BEGIN
                         SET @ERRORNBR = 300
                         SET @PPResultParms = ''
                         SET @PPErrTable = 'Utilization Period'
                         GOTO ABORT
                    END        
                 END
              /*************** End of Get_UZPeriod ******************/
   
              IF @BaseCuryID = @ProjCuryID
                 BEGIN
                   SET @ProjCurrencyRate = 1
                   SET @ProjCuryEffDate = GETDATE()
                   SET @ProjCury_amount = @Amt
                   SET @ProjCuryRateType = ''
                 END
              ELSE  
                 BEGIN
                    SET @CurrencyRate = ISNULL((SELECT Top 1(rate) 
                                                  FROM CuryRate WITH(NOLOCK)
                                                 WHERE FromCuryId like @BaseCuryID
                                                   AND ToCuryId like @ProjCuryID 
                                                   AND RateType like @ProjCuryRateType
                                                   AND EffDate <= @TimDetTLDate
                                                 ORDER BY FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC),0)
                    IF @CurrencyRate = 0 
                       BEGIN
                         SET @ERRORNBR = 1789
                         SET @PPResultParms = RTRIM(LTRIM(@BaseCuryID)) + ' | ' +  RTRIM(LTRIM(@ProjCuryID))
                         Set @PPErrTable = 'Currency Rate'
                         GOTO ABORT
                       END
                    SET @CurrencyMultDiv = ISNULL((SELECT Top 1(MultDiv) 
                                                       FROM CuryRate WITH(NOLOCK)
                                                      WHERE FromCuryId like @BaseCuryID
                                                        AND ToCuryId like @ProjCuryID 
                                                        AND RateType like @ProjCuryRateType
                                                        AND EffDate <= @TimDetTLDate
                                                        AND rate = @CurrencyRate
                                                      ORDER BY FromCuryId DESC, ToCuryId DESC, RateType DESC, EffDate DESC),0)      
                    SET @ProjCuryEffDate = @TimDetTLDate
                    SET @ProjCury_amount = CASE @CurrencyMultDiv 
                                             WHEN 'M' THEN ROUND(@Amt * @CurrencyRate, @ProjCuryPrecision) 
                                                      ELSE ROUND(@Amt / @CurrencyRate, @ProjCuryPrecision) END 
                    SET @ProjCurrencyRate = CASE WHEN ROUND(@Amt / @ProjCury_amount, 9) < 0 
                                                  THEN ROUND(@Amt / @ProjCury_amount, 9) * -1
                                                  ELSE ROUND(@Amt / @ProjCury_amount, 9) END
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
               SELECT @PJLABDIS_acct, CASE SUBSTRING(@gAllocOption,1,1) WHEN 'Y' THEN 'A' ELSE '' END, @Amt, h.BaseCuryId, h.docnbr, 
                      'LABR', h.docnbr, t.CpnyId_chrg, GETDATE(), @ProgID, 
                      @SolUser, CAST(0x00000000 AS SmallDateTime), h.BaseCuryId, 'M', 1, 
                      '', 0, '', 
                      @Detail_Num, t.employee,                       --SCE Need to fix @Detail_Num
                      @gPostPeriod, @PJLABDIS_gl_acct, t.gl_subacct, GETDATE(), @ProgID, 
                      @SolUser, 0, t.pjt_entity, CAST(0x00000000 AS SmallDateTime), t.project, 
                      '', t.SubTask_Name, 'TM', t.tl_date, h.th_comment, 
                      '', '', '', '', t.labor_class_cd, 
                      0, 0, CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 0, 
                      '', @PJTRAN_TR_ID24, '', @UZPeriod, '',      
                      0, CAST(0x00000000 AS SmallDateTime), 0, 0, 0, 
                      t.tl_id17, '', @wHrs, t.user1, t.user2, 
                      t.user3, t.user4, '', t.linenbr, '',
                      @ProjCury_amount, @ProjCuryEffDate, @ProjCuryID , 'M', @ProjCurrencyRate, 
                      @ProjCuryRateType, CAST(0x00000000 AS SmallDateTime), '', '', 
                      0, ''      
                 FROM PJTIMDET t JOIN PJTIMHDR h
                                   ON t.docnbr = h.docnbr
                WHERE t.docnbr = @DocNbr
                  AND t.linenbr = @LineNbr 
               IF @@ERROR <> 0
                  BEGIN
                     SET @ERRORNBR = 225
                     SET @PPResultParms = ''
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
               SELECT t.docnbr, GETDATE(), @ProgID, @SolUser, @Detail_Num, 
                      '', @gPostPeriod, '', '', GETDATE(), 
                      @ProgID, @SolUser, '', '', '', 
                      '', '', 'TM', @gPostPeriod + 'TM' + t.docnbr + RIGHT('0000000000' + CAST(@Detail_Num AS VARCHAR(10)), 10), '', 
                      '', '', '', CASE WHEN @PJPENTEX_PE_ID13 <> '' 
                                         THEN RIGHT('      ' + @PJPENTEX_PE_ID13,6) + RIGHT('  ' + t.work_type,2)
                                       ELSE CASE WHEN @PJPROJEX_work_location <> '' 
                                                   THEN RIGHT('      ' + @PJPROJEX_work_location, 6) + RIGHT('  ' + t.work_type,2)
                                                 ELSE CASE WHEN @Employee_DfltWrkLoc <> ''
                                                            THEN RIGHT('      ' + @Employee_DfltWrkLoc, 6) + RIGHT('  ' + t.work_type,2)
                                                           ELSE '      ' + RIGHT('  ' + t.work_type,2) END END END, '', 
                      '', '', '', '', h.th_date, 
                      '', '', ''
                 FROM PJTIMDET t WITH(NOLOCK) JOIN PJTIMHDR h WITH(NOLOCK) 
                                                ON t.docnbr = h.docnbr
                WHERE t.docnbr = @DocNbr
                  AND t.linenbr = @LineNbr 
               If @@ERROR <> 0
                  BEGIN
                     SET @ERRORNBR = 250
                     SET @PPResultParms = ''
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
                           SET @ERRORNBR = 275
                           SET @PPResultParms = ''
                           SET @PPErrTable = 'PJTRANWRK'
                           GOTO ABORT
                        END         
                  END     --IF SUBSTRING(@gAllocOption,1,1) = 'Y'            
            
               EXEC pp_TimesheetUPDATE_PJACTRolACTSum @PJLABDIS_acct, @gPostPeriod, @TimDetProject, @TimDetTask,
                                                      @Amt, @wHrs, @ProgID, @SolUser, 
                                                      @ProjCury_amount, @ProjCuryPrecision, @BasePrecision,
                                                      @PPResult OUTPUT, @PPErrTable OUTPUT
               If @PPResult <> 0
                  BEGIN
                     SET @ERRORNBR = @PPResult
                     SET @PPResultParms = ''
                     SET @PPErrTable = @PPErrTable
                     GOTO ABORT
                  END
 
               EXEC pp_TimesheetUPDATE_PJPTDRolPTDSum @PJLABDIS_acct, @TimDetProject, @TimDetTask, @Amt,
                                                  @wHrs, @ProgID, @SolUser, @TimDetEmployee, @TimDetSubTaskName,
                                                  @gUZActive, @UZPeriod, @MSP_Interface, 
                                                  @ProjCury_amount, @ProjCuryPrecision, @BasePrecision,
                                                  @PPResult OUTPUT, @PPErrTable OUTPUT  
               If @PPResult <> 0
               BEGIN
                  SET @ERRORNBR = @PPResult
                  SET @PPResultParms = ''
                  SET @PPErrTable = @PPErrTable
                  GOTO ABORT
               END 
        END  --If @tmsetup_post_ot_flg <> 'Y' OR LEFT(@Hr_Type,2) <> 'OT' OR  @PayType <> 'HR' OR @pHrs = 0 OR @tmsetup_post_flg <> 'N'
 
      END    --IF (@wHrs + @pHrs <> 0 OR @Amt <> 0)
          
 SELECT @PPResult = 0
 SELECT @PPErrTable = ''
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
    88  - Unable to post to PJLABDIS, possible dup key. Timecard # ($1), Line # ($2), Hours Type ($3)
    200 - Error Retrieving PJTimDet Record.
    225 - PJTran Insert
    250 - PJTranEx Insert
    275 - PJTranWrk Insert
    1789 - CuryRate not found 
    
    Stored Procs Called from this Stored Proc
    31   - PJ_Account (Acct Category)
    1000 - PJACTROL Insert
    1100 - PJACTROL Update
    1200 - PJACTSUM Insert
    1300 - PJACTSUM Update
    2000 - PJPTDROL Insert
    2100 - PJPTDROL Update
    2200 - Error Selecting Project Employee Utilization Information
    2300 - PJUTLROL Insert
    2400 - PJUTLROL Update
    2500 - PJPENTEM Insert
    2600 - PJPENTEM Update
    2700 - PJPTDSUM Insert
    2800 - PJPTDSUM Update  
 **/
 SELECT @PPResult = @ERRORNBR

 FINISH:
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_Post_Labor_Cost] TO [MSDSL]
    AS [dbo];

