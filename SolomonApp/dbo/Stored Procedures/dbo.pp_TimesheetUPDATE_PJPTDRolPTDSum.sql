 
 CREATE PROCEDURE pp_TimesheetUPDATE_PJPTDRolPTDSum @Acct VARCHAR(16), @Project VARCHAR(16), @Task VARCHAR(32),
                                                    @Amount FLOAT, @Units FLOAT, @ProgID VARCHAR(8), @SolUser Varchar(10),
                                                    @Employee VARCHAR(10), @SubTaskName VARCHAR(50), @gUZActive INTEGER,
                                                    @UZPeriod VARCHAR(10), @MSP_Interface VARCHAR(1), 
                                                    @ProjCuryAmount FLOAT, @ProjCuryPrecision As INT, @BasePrecision INT,
                                                    @PPResult INT OUTPUT, @PPErrTable VARCHAR(20) OUTPUT                                 
AS
 
  DECLARE @ERRORNBR INT
  DECLARE @ProceedWithUZCalc VARCHAR(3)
     
  --MSPUZInfo VARIABLES   
  DECLARE @UZInfoStartDate SmallDateTime 
  DECLARE @UZInfoEndDate SmallDateTime 
  DECLARE @UZInfoProject_MSPID VARCHAR(36)
  DECLARE @UZInfoUZType VARCHAR(4)
  DECLARE @UZInfoUZTranClass VARCHAR(1)
  DECLARE @UZInfoMSPAcctType VARCHAR(1)
  DECLARE @UZInfoMSPInterface VARCHAR(1)
  DECLARE @UZInfoEmployee_MSPID  VARCHAR(36)
  DECLARE @UZInfoProject VARCHAR(16)

  IF (SELECT project FROM PJPTDROL WHERE project = @Project AND acct = @Acct) is null
     BEGIN 
        INSERT PJPTDROL (acct, act_amount, act_units, com_amount, com_units, 
                         crtd_datetime, crtd_prog, crtd_user, data1, data2, 
                         data3, data4, data5, eac_amount, eac_units, 
                         fac_amount, fac_units, lupd_datetime, lupd_prog, lupd_user,
                         ProjCury_act_amount, ProjCury_com_amount, ProjCury_eac_amount, ProjCury_fac_amount, 
                         ProjCury_rate, ProjCury_tot_bud_amt, 
                         project, rate, total_budget_amount, total_budget_units, user1, 
                         user2, user3, user4)
        VALUES (@Acct, @Amount, @Units, 0, 0, 
                GETDATE(), @ProgID, @SolUser, '', 0, 
                0, 0, 0, 0, 0, 
                0, 0, GETDATE(), @ProgID, @SolUser, 
                @ProjCuryAmount, 0, 0, 0,
                0, 0,
                @Project, 0, 0, 0, '', 
                '', 0, 0) 
        IF @@ERROR <> 0
           BEGIN
             SET @ERRORNBR = 2000
             SET @PPErrTable = 'PJPTDROL'
             GOTO ABORT
           END                 
      END
  ELSE
     BEGIN
        UPDATE PJPTDROL 
           SET act_amount = ROUND(act_amount + @Amount, @BasePrecision),
               act_units = ROUND(act_units + @Units, 2),
               lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser,  
               ProjCury_act_amount = ROUND(ProjCury_act_amount + @ProjCuryAmount, @ProjCuryPrecision)                 
         WHERE project = @Project
           AND acct = @Acct
       IF @@ERROR <> 0
          BEGIN
             SET @ERRORNBR = 2100
             SET @PPErrTable = 'PJPTDROL'
             GOTO ABORT
          END            
     END   

  --MS Project Integration turned "ON" OR Employee data to POST to PJPENTEM/UZ
  IF @MSP_Interface = 'Y' AND RTRIM(@Employee) <> '' 
     BEGIN
        SELECT @UZInfoStartDate = t.start_date, @UZInfoEndDate = t.end_date, @UZInfoProject_MSPID = px.Project_MSPID, @UZInfoUZType = p.pm_id37, 
               @UZInfoUZTranClass = a.id5_sw, @UZInfoMSPAcctType = a.ca_id20, @UZInfoMSPInterface = t.mspinterface, @UZInfoEmployee_MSPID = ex.Employee_MSPID,
               @UZInfoProject = p.project
          FROM PJPROJ p INNER JOIN PJPENT t ON p.project = t.project 
                        LEFT OUTER JOIN PJPROJXREFMSP px ON p.project = px.project,
               PJEMPLOY e LEFT OUTER JOIN PJEMPLOYXREFMSP ex ON e.employee = ex.employee,
               PJACCT a 
         WHERE p.project = @Project 
           AND t.pjt_entity = @Task
           AND e.employee = @Employee    
           AND a.acct = @Acct
         IF @@ERROR <> 0
            BEGIN
               SET @ERRORNBR = 2200
               SET @PPErrTable = ''
               GOTO ABORT
            END 
     
        IF @UZInfoProject IS NULL
           BEGIN
              SET @ProceedWithUZCalc = 'NO'  
           END
        ELSE
           BEGIN
              SET @ProceedWithUZCalc = 'YES' 
           END
        IF @UZInfoUZTranClass IS NULL            
          SET @UZInfoUZTranClass = ''
        
        IF @gUZActive = 1 AND @ProceedWithUZCalc = 'YES' AND RTRIM(@UZInfoUZType) <> '' AND RTRIM(@UZPeriod) <> '' AND RTRIM(@Employee) <> '' AND RTRIM(LTRIM(@UZInfoUZTranClass)) <> ''
           BEGIN             
              IF (SELECT employee FROM PJUTLROL WITH(NOLOCK) WHERE employee = @Employee AND fiscalno = @UZPeriod AND utilization_type = @UZInfoUZType) is null
                 BEGIN 
                    INSERT PJUTLROL (adjustments, cost, crtd_datetime, crtd_prog, crtd_user, 
                                     data1, data2, data3, data4, data5, 
                                     employee, fiscalno, lupd_datetime, lupd_prog, lupd_user, 
                                     rate, revenue, units, user1, user2, 
                                     user3, user4, utilization_type)
                     VALUES (CASE @UZInfoUZTranClass WHEN 'L' THEN 0
                                                     WHEN 'R' THEN 0
                                                     WHEN 'A' THEN @Amount
                                                     WHEN 'X' THEN 0 END, 
                             CASE @UZInfoUZTranClass WHEN 'L' THEN @Amount
                                                     WHEN 'R' THEN 0
                                                     WHEN 'A' THEN 0
                                                     WHEN 'X' THEN @Amount END, GETDATE(), @ProgID, @SolUser, 
                             '', 0, 0, 0, 0, 
                             @Employee, @UZPeriod, GETDATE(), @ProgID, @SolUser, 
                             CASE WHEN @UZInfoUZTranClass = 'L' OR @UZInfoUZTranClass = 'X' 
                                       THEN CASE @Units WHEN 0 THEN 0
                                                                   ELSE ROUND(@Amount / @Units, 2) END
                                       ELSE 0 END, 
                             CASE @UZInfoUZTranClass WHEN 'L' THEN 0
                                                     WHEN 'R' THEN @Amount
                                                     WHEN 'A' THEN 0
                                                     WHEN 'X' THEN 0 END, 
                             CASE @UZInfoUZTranClass WHEN 'L' THEN @Units
                                                     WHEN 'R' THEN 0
                                                     WHEN 'A' THEN 0
                                                     WHEN 'X' THEN 0 END, '', '', 
                             0, 0, @UZInfoUZType)
                     IF @@ERROR <> 0
                        BEGIN
                           SET @ERRORNBR = 2300
                           SET @PPErrTable = 'PJUTLROL'
                           GOTO ABORT
                        END         

                 END
              ELSE
                 BEGIN
                    UPDATE PJUTLROL 
                       SET adjustments = CASE @UZInfoUZTranClass WHEN 'L' THEN adjustments
                                                                 WHEN 'R' THEN adjustments
                                                                 WHEN 'A' THEN ROUND (@Amount + adjustments, 2)
                                                                 WHEN 'X' THEN adjustments END,
                           cost = CASE @UZInfoUZTranClass WHEN 'L' THEN ROUND(@Amount + cost, 2)
                                                          WHEN 'R' THEN cost
                                                          WHEN 'A' THEN cost
                                                          WHEN 'X' THEN ROUND(@Amount + cost, 2) END,
                           revenue = CASE @UZInfoUZTranClass WHEN 'L' THEN revenue
                                                             WHEN 'R' THEN ROUND(@Amount + revenue, 2)
                                                             WHEN 'A' THEN revenue
                                                             WHEN 'X' THEN revenue END,
                           units = CASE @UZInfoUZTranClass WHEN 'L' THEN ROUND(@Units + units, 2)
                                                           WHEN 'R' THEN units
                                                           WHEN 'A' THEN units
                                                           WHEN 'X' THEN units END,
                           rate = CASE WHEN @UZInfoUZTranClass = 'L' OR @UZInfoUZTranClass = 'X' 
                                        THEN CASE ROUND(@Units + units, 2) WHEN 0 
                                                                             THEN 0
                                                                           ELSE ROUND(ROUND(@Amount + cost, 2) / ROUND(@Units + units, 2), 2) END
                                         ELSE 0 END,
                           lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser                                      
                     WHERE employee = @Employee AND fiscalno = @UZPeriod AND utilization_type = @UZInfoUZType
                    IF @@ERROR <> 0
                       BEGIN
                          SET @ERRORNBR = 2400
                          SET @PPErrTable = 'PJUTLROL'
                          GOTO ABORT
                       END 
                 END --IF (SELECT employee FROM PJUTLROL WITH(NOLOCK) WHERE employee = @Employee AND fiscalno = @UZPeriod AND utilization_type = @UZInfoUZType) is null  
           END     --IF @gUZActive = 1 AND @ProceedWithUZCalc = 'YES' AND RTRIM(@UZInfoUZType) <> '' AND RTRIM(@UZPeriod) <> '' 
        
        IF LTRIM(RTRIM(@UZInfoUZTranClass)) IN ('R','L','X','A') AND RTRIM(@Employee) <> ''
           BEGIN
           
              IF (SELECT project FROM PJPENTEM WITH(NOLOCK) WHERE project = @Project AND pjt_entity = @Task AND employee = @Employee AND SubTask_Name = @SubTaskName ) is null
                 BEGIN 
                    INSERT PJPENTEM (Actual_amt, Actual_units, Budget_amt, Budget_units, Comment, 
                                     crtd_datetime, crtd_prog, crtd_user, Date_start, Date_end, 
                                     Employee, lupd_datetime, lupd_prog, lupd_user, MSPSync, 
                                     noteid, Pjt_entity, 
                                     ProjCury_Actual_amt, ProjCury_Budget_amt, ProjCury_Revadj_amt, ProjCury_Revenue_amt,
                                     ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate, ProjCuryRateType,
                                     Project, Revadj_amt, Revenue_amt, 
                                     SubTask_Name, SubTask_UID, Tk_id01, Tk_id02, Tk_id03, 
                                     Tk_id04, Tk_id05, Tk_id06, Tk_id07, Tk_id08, 
                                     Tk_id09, Tk_id10, User1, User2, User3, 
                                     User4)
                    VALUES (CASE @UZInfoUZTranClass WHEN 'L' THEN @Amount
                                                    WHEN 'R' THEN 0
                                                    WHEN 'A' THEN 0
                                                    WHEN 'X' THEN @Amount END,
                            CASE @UZInfoUZTranClass WHEN 'L' THEN @Units
                                                    WHEN 'R' THEN 0
                                                    WHEN 'A' THEN 0
                                                    WHEN 'X' THEN @Units END, 0, 0, '', 
                            GETDATE(), @ProgID, @SolUser, CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 
                            @Employee, GETDATE(), @ProgID, @SolUser, '', 
                            0, @Task, 
                            CASE @UZInfoUZTranClass WHEN 'L' THEN @ProjCuryAmount 
                                                    WHEN 'R' THEN 0
                                                    WHEN 'A' THEN 0
                                                    WHEN 'X' THEN @ProjCuryAmount END, 0,
                            CASE @UZInfoUZTranClass WHEN 'L' THEN 0
                                                    WHEN 'R' THEN 0
                                                    WHEN 'A' THEN @ProjCuryAmount
                                                    WHEN 'X' THEN 0 END, 
                            CASE @UZInfoUZTranClass WHEN 'L' THEN 0
                                                    WHEN 'R' THEN @ProjCuryAmount
                                                    WHEN 'A' THEN 0
                                                    WHEN 'X' THEN 0 END, 
                            CAST(0x00000000 AS SmallDateTime), '', '', 0, '',                                                
                            @Project, 
                            CASE @UZInfoUZTranClass WHEN 'L' THEN 0
                                                    WHEN 'R' THEN 0
                                                    WHEN 'A' THEN @Amount
                                                    WHEN 'X' THEN 0 END, 
                            CASE @UZInfoUZTranClass WHEN 'L' THEN 0
                                                    WHEN 'R' THEN @Amount
                                                    WHEN 'A' THEN 0
                                                    WHEN 'X' THEN 0 END, 
                            @SubTaskName, 0, '', '', '', 
                            '', '', 0, 0, CAST(0x00000000 AS SmallDateTime), 
                            CAST(0x00000000 AS SmallDateTime), 0, '', '', 0, 
                            0) 
                    IF @@ERROR <> 0
                        BEGIN
                           SET @ERRORNBR = 2500
                           SET @PPErrTable = 'PJPENTEM'
                           GOTO ABORT
                        END                          
                 END
              ELSE
                 BEGIN
                    UPDATE PJPENTEM 
                       SET Actual_amt = CASE @UZInfoUZTranClass WHEN 'L' THEN ROUND (@Amount + Actual_amt, @BasePrecision)
                                                                WHEN 'R' THEN Actual_amt
                                                                WHEN 'A' THEN Actual_amt
                                                                WHEN 'X' THEN ROUND (@Amount + Actual_amt, @BasePrecision) END,
                           Actual_units = CASE @UZInfoUZTranClass WHEN 'L' THEN ROUND(@Units + Actual_units, 2)
                                                                  WHEN 'R' THEN Actual_units
                                                                  WHEN 'A' THEN Actual_units
                                                                  WHEN 'X' THEN ROUND(@Units + Actual_units, 2) END,
                           Revenue_amt = CASE @UZInfoUZTranClass WHEN 'L' THEN Revenue_amt
                                                                 WHEN 'R' THEN ROUND(@Amount + Revenue_amt, @BasePrecision)
                                                                 WHEN 'A' THEN Revenue_amt
                                                                 WHEN 'X' THEN Revenue_amt END,
                           Revadj_amt = CASE @UZInfoUZTranClass WHEN 'L' THEN Revadj_amt
                                                                WHEN 'R' THEN Revadj_amt
                                                                WHEN 'A' THEN ROUND(@Amount + Revadj_amt, @BasePrecision)
                                                                WHEN 'X' THEN Revadj_amt END,
                           ProjCury_Actual_amt = CASE @UZInfoUZTranClass WHEN 'L' THEN ROUND (@ProjCuryAmount + ProjCury_Actual_amt, @ProjCuryPrecision )
                                                                         WHEN 'R' THEN ProjCury_Actual_amt
                                                                         WHEN 'A' THEN ProjCury_Actual_amt
                                                                         WHEN 'X' THEN ROUND (@ProjCuryAmount + ProjCury_Actual_amt, @ProjCuryPrecision ) END,                                                                
                           ProjCury_Revenue_amt = CASE @UZInfoUZTranClass WHEN 'L' THEN ProjCury_Revenue_amt
                                                                          WHEN 'R' THEN ROUND(@ProjCuryAmount + ProjCury_Revenue_amt, @ProjCuryPrecision)
                                                                          WHEN 'A' THEN ProjCury_Revenue_amt
                                                                          WHEN 'X' THEN ProjCury_Revenue_amt END,
                           ProjCury_Revadj_amt = CASE @UZInfoUZTranClass WHEN 'L' THEN ProjCury_Revadj_amt
                                                                         WHEN 'R' THEN ProjCury_Revadj_amt
                                                                         WHEN 'A' THEN ROUND(@ProjCuryAmount + ProjCury_Revadj_amt, @ProjCuryPrecision)
                                                                         WHEN 'X' THEN ProjCury_Revadj_amt END,                                                                
                           lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser                 
                    WHERE project = @Project AND pjt_entity = @Task 
                      AND employee = @Employee AND SubTask_Name = @SubTaskName
                    IF @@ERROR <> 0
                       BEGIN
                          SET @ERRORNBR = 2600
                          SET @PPErrTable = 'PJPENTEM'
                          GOTO ABORT
                       END 
                 END                              
           END   --IF LTRIM(RTRIM(@UZInfoUZTranClass)) IN ('L','R','A','X')   
     END    --IF @MSP_Interface = 'Y' AND RTRIM(@Employee) <> ''

 
  IF (SELECT project FROM PJPTDSUM WITH(NOLOCK) WHERE project =  @Project AND pjt_entity = @Task AND acct = @Acct) is null
     BEGIN 
        INSERT PJPTDSUM (acct, act_amount, act_units, com_amount, com_units, 
                         crtd_datetime, crtd_prog, crtd_user, data1, data2, 
                         data3, data4, data5, eac_amount, eac_units, 
                         fac_amount, fac_units, lupd_datetime, lupd_prog, lupd_user, 
                         noteid, pjt_entity, 
                         ProjCury_act_amount, ProjCury_com_amount, ProjCury_eac_amount, 
                         ProjCury_fac_amount, ProjCury_rate, ProjCury_tot_bud_amt,
                         project, rate, total_budget_amount, 
                         total_budget_units, user1, user2, user3, user4)
        VALUES (@Acct, @Amount, @Units, 0, 0, 
                GETDATE(), @ProgID, @SolUser, '', 0, 
                0, 0, 0, 0, 0, 
                0, 0, GETDATE(), @ProgID, @SolUser, 
                0, @Task, 
                @ProjCuryAmount, 0, 0,
                0, 0, 0,
                @Project, 0, 0, 
                0, '', '', 0, 0)
        IF @@ERROR <> 0
           BEGIN
              SET @ERRORNBR = 2700
              SET @PPErrTable = 'PJPTDSUM'
              GOTO ABORT
          END                                                     
     END
  ELSE
     BEGIN
        UPDATE PJPTDSUM 
           SET act_amount = ROUND(act_amount + @Amount,@BasePrecision),
               act_units = ROUND(act_units + @Units, 2),
               lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser,
               ProjCury_act_amount = ROUND(ProjCury_act_amount + @ProjCuryAmount, @ProjCuryPrecision)   
         WHERE project =  @Project AND pjt_entity = @Task AND acct = @Acct
        IF @@ERROR <> 0
           BEGIN
              SET @ERRORNBR = 2800
              SET @PPErrTable = 'PJPTDSUM'
              GOTO ABORT
          END 
     END
     
 SELECT @PPResult = 0
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
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
    ON OBJECT::[dbo].[pp_TimesheetUPDATE_PJPTDRolPTDSum] TO [MSDSL]
    AS [dbo];

