
CREATE PROCEDURE  pp_BudgetRevisionBudSumRol @ProjectID VarChar(16), @RevId VarChar(4), @TaskID VarChar(32), @Acct VarChar(16), @UserID VarChar(10),
                                   @ProgID VarChar(8), @update_type VarChar(1), @RevisionType VarChar(2),
                                   @BasePrecision Int, @ProjCuryPrecision Int, @UnitPrecision Int, @PPResult INT OUTPUT
AS

  DECLARE @fsyear_changed VarChar(4) = ''
 DECLARE @prev_fsyear_num VarChar(4) = ''
 DECLARE @First_record VarChar(4) = 'TRUE'

 DECLARE @TempPJBudSum_fsyear_num VarChar(4)
 DECLARE @TempPJBudSum_Amount01 Float, @TempPJBudSum_Amount02 Float, @TempPJBudSum_Amount03 Float, @TempPJBudSum_Amount04 Float, @TempPJBudSum_Amount05 Float
 DECLARE @TempPJBudSum_Amount06 Float, @TempPJBudSum_Amount07 Float, @TempPJBudSum_Amount08 Float, @TempPJBudSum_Amount09 Float, @TempPJBudSum_Amount10 Float
 DECLARE @TempPJBudSum_Amount11 Float, @TempPJBudSum_Amount12 Float, @TempPJBudSum_Amount13 Float, @TempPJBudSum_Amount14 Float, @TempPJBudSum_Amount15 Float
 DECLARE @TempPJBudSum_ProjCury_Amount01 Float, @TempPJBudSum_ProjCury_Amount02 Float, @TempPJBudSum_ProjCury_Amount03 Float, @TempPJBudSum_ProjCury_Amount04 Float, @TempPJBudSum_ProjCury_Amount05 Float
 DECLARE @TempPJBudSum_ProjCury_Amount06 Float, @TempPJBudSum_ProjCury_Amount07 Float, @TempPJBudSum_ProjCury_Amount08 Float, @TempPJBudSum_ProjCury_Amount09 Float, @TempPJBudSum_ProjCury_Amount10 Float
 DECLARE @TempPJBudSum_ProjCury_Amount11 Float, @TempPJBudSum_ProjCury_Amount12 Float, @TempPJBudSum_ProjCury_Amount13 Float, @TempPJBudSum_ProjCury_Amount14 Float, @TempPJBudSum_ProjCury_Amount15 Float
 DECLARE @TempPJBudSum_Units01 Float, @TempPJBudSum_Units02 Float, @TempPJBudSum_Units03 Float, @TempPJBudSum_Units04 Float, @TempPJBudSum_Units05 Float
 DECLARE @TempPJBudSum_Units06 Float, @TempPJBudSum_Units07 Float, @TempPJBudSum_Units08 Float, @TempPJBudSum_Units09 Float, @TempPJBudSum_Units10 Float
 DECLARE @TempPJBudSum_Units11 Float, @TempPJBudSum_Units12 Float, @TempPJBudSum_Units13 Float, @TempPJBudSum_Units14 Float, @TempPJBudSum_Units15 Float

 DECLARE @Total_Amount Float
 DECLARE @ProjCury_Total_Amount Float
 DECLARE @Total_Units Float
 SET @Total_Amount = 0
 SET @ProjCury_Total_Amount = 0
 SET @Total_Units = 0

 DECLARE @ERRORNBR INT

/** PJRevTim_Csr Cursor Variables **/
Declare @PJRevTimFicalNo VarChar(6), @PJRevTimAmount Float, @PJRevTimProjCuryAmount Float, @RPJRevTimUnits Float, @PJREVTimRate Float, @PJREVTimProjCuryRate Float

DECLARE PJRevTim_Csr INSENSITIVE CURSOR FOR
   SELECT fiscalno, Amount, ProjCUry_Amount, Units, Rate, ProjCury_Rate
     FROM PJREVTIM
    WHERE RevId = @RevId
      AND Project = @ProjectID
      AND Pjt_Entity = @TaskID
      AND Acct = @Acct
    ORDER BY  revid, project, pjt_entity, acct, fiscalno

OPEN PJRevTim_Csr
FETCH PJRevTim_Csr INTO @PJRevTimFicalNo, @PJRevTimAmount, @PJRevTimProjCuryAmount, @RPJRevTimUnits, @PJREVTimRate, @PJREVTimProjCuryRate
IF @@ERROR <> 0
BEGIN
    CLOSE PJRevTim_Csr
    DEALLOCATE PJRevTim_Csr
    SET @ERRORNBR = 200
    GOTO ABORT
END

WHILE @@FETCH_STATUS = 0
   BEGIN
      If LEFT(@PJRevTimFicalNo,4) <> @prev_fsyear_num OR @First_record = 'TRUE'
      BEGIN
         if @First_record <> 'TRUE'
         begin
            If @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
            Begin
               --Update_PJBUDSUM_AND_ROL("00")
               EXEC UPDATE_PJBUDSUMBUDROL @TempPJBudSum_fsyear_num, @ProjectID, @TaskID, @RevId, @Acct, '00',
                          @UserID, @ProgID, @RevisionType, @PJREVTimRate, @PJREVTimProjCuryRate ,@Total_Amount, @ProjCury_Total_Amount, @Total_Units,
                          @TempPJBudSum_Amount01, @TempPJBudSum_Amount02, @TempPJBudSum_Amount03,
                          @TempPJBudSum_Amount04, @TempPJBudSum_Amount05, @TempPJBudSum_Amount06,
                          @TempPJBudSum_Amount07, @TempPJBudSum_Amount08, @TempPJBudSum_Amount09,
                          @TempPJBudSum_Amount10, @TempPJBudSum_Amount11, @TempPJBudSum_Amount12,
                          @TempPJBudSum_Amount13, @TempPJBudSum_Amount14, @TempPJBudSum_Amount15,
                          @TempPJBudSum_ProjCury_Amount01, @TempPJBudSum_ProjCury_Amount02, @TempPJBudSum_ProjCury_Amount03,
                          @TempPJBudSum_ProjCury_Amount04, @TempPJBudSum_ProjCury_Amount05, @TempPJBudSum_ProjCury_Amount06,
                          @TempPJBudSum_ProjCury_Amount07, @TempPJBudSum_ProjCury_Amount08, @TempPJBudSum_ProjCury_Amount09,
                          @TempPJBudSum_ProjCury_Amount10, @TempPJBudSum_ProjCury_Amount11, @TempPJBudSum_ProjCury_Amount12,
                          @TempPJBudSum_ProjCury_Amount13, @TempPJBudSum_ProjCury_Amount14, @TempPJBudSum_ProjCury_Amount15,
                          @TempPJBudSum_Units01, @TempPJBudSum_Units02, @TempPJBudSum_Units03,
                          @TempPJBudSum_Units04, @TempPJBudSum_Units05, @TempPJBudSum_Units06,
                          @TempPJBudSum_Units07, @TempPJBudSum_Units08, @TempPJBudSum_Units09,
                          @TempPJBudSum_Units10, @TempPJBudSum_Units11, @TempPJBudSum_Units12,
                          @TempPJBudSum_Units13, @TempPJBudSum_Units14, @TempPJBudSum_Units15,
                          @BasePrecision, @ProjCuryPrecision, @UnitPrecision, @PPResult OUTPUT
               IF @PPResult <> 0
               BEGIN
                  CLOSE PJRevTim_Csr
                  DEALLOCATE PJRevTim_Csr
                  -- 2000 - PJBUDSUM
                  -- 3000 - PJBUDROL
                  -- 4000 - PJBUDSUM Future Summary
                  -- 5000 - PJBUDROL Future Summary
                  SET @ERRORNBR = @PPResult
                  GOTO ABORT
               END
            End

            If @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
            Begin
               -- Update_PJBUDSUM_AND_ROL("  ")
               EXEC UPDATE_PJBUDSUMBUDROL @TempPJBudSum_fsyear_num, @ProjectID, @TaskID, @RevId, @Acct, ' ',
                          @UserID, @ProgID, @RevisionType, @PJREVTimRate, @PJREVTimProjCuryRate, @Total_Amount, @ProjCury_Total_Amount, @Total_Units,
                          @TempPJBudSum_Amount01, @TempPJBudSum_Amount02, @TempPJBudSum_Amount03,
                          @TempPJBudSum_Amount04, @TempPJBudSum_Amount05, @TempPJBudSum_Amount06,
                          @TempPJBudSum_Amount07, @TempPJBudSum_Amount08, @TempPJBudSum_Amount09,
                          @TempPJBudSum_Amount10, @TempPJBudSum_Amount11, @TempPJBudSum_Amount12,
                          @TempPJBudSum_Amount13, @TempPJBudSum_Amount14, @TempPJBudSum_Amount15,
                          @TempPJBudSum_ProjCury_Amount01, @TempPJBudSum_ProjCury_Amount02, @TempPJBudSum_ProjCury_Amount03,
                          @TempPJBudSum_ProjCury_Amount04, @TempPJBudSum_ProjCury_Amount05, @TempPJBudSum_ProjCury_Amount06,
                          @TempPJBudSum_ProjCury_Amount07, @TempPJBudSum_ProjCury_Amount08, @TempPJBudSum_ProjCury_Amount09,
                          @TempPJBudSum_ProjCury_Amount10, @TempPJBudSum_ProjCury_Amount11, @TempPJBudSum_ProjCury_Amount12,
                          @TempPJBudSum_ProjCury_Amount13, @TempPJBudSum_ProjCury_Amount14, @TempPJBudSum_ProjCury_Amount15,
                          @TempPJBudSum_Units01, @TempPJBudSum_Units02, @TempPJBudSum_Units03,
                          @TempPJBudSum_Units04, @TempPJBudSum_Units05, @TempPJBudSum_Units06,
                          @TempPJBudSum_Units07, @TempPJBudSum_Units08, @TempPJBudSum_Units09,
                          @TempPJBudSum_Units10, @TempPJBudSum_Units11, @TempPJBudSum_Units12,
                          @TempPJBudSum_Units13, @TempPJBudSum_Units14, @TempPJBudSum_Units15,
                          @BasePrecision, @ProjCuryPrecision, @UnitPrecision, @PPResult OUTPUT
               IF @PPResult <> 0
               BEGIN
                  CLOSE PJRevTim_Csr
                  DEALLOCATE PJRevTim_Csr
                  -- 2000 - PJBUDSUM
                  -- 3000 - PJBUDROL
                  -- 4000 - PJBUDSUM Future Summary
                  -- 5000 - PJBUDROL Future Summary
                  SET @ERRORNBR = @PPResult
                  GOTO ABORT
               END 
            End
         end --@First_record <> 'TRUE'

         if @RevisionType = 'NA'
         begin
            If @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
            Begin
               --Backout_PJBUDROL("00")
               UPDATE r
               SET r.amount_01 = ROUND(r.amount_01 - s.amount_01, @BasePrecision), r.amount_02 = ROUND(r.amount_02 - s.amount_02, @BasePrecision),
                     r.amount_03 = ROUND(r.amount_03 - s.amount_03, @BasePrecision), r.amount_04 = ROUND(r.amount_04 - s.amount_04, @BasePrecision),
                     r.amount_05 = ROUND(r.amount_05 - s.amount_05, @BasePrecision), r.amount_06 = ROUND(r.amount_06 - s.amount_06, @BasePrecision),
                     r.amount_07 = ROUND(r.amount_07 - s.amount_07, @BasePrecision), r.amount_08 = ROUND(r.amount_08 - s.amount_08, @BasePrecision),
                     r.amount_09 = ROUND(r.amount_09 - s.amount_09, @BasePrecision), r.amount_10 = ROUND(r.amount_10 - s.amount_10, @BasePrecision),
                     r.amount_11 = ROUND(r.amount_11 - s.amount_11, @BasePrecision), r.amount_12 = ROUND(r.amount_12 - s.amount_12, @BasePrecision),
                     r.amount_13 = ROUND(r.amount_13 - s.amount_13, @BasePrecision), r.amount_14 = ROUND(r.amount_14 - s.amount_14, @BasePrecision),
                     r.amount_15 = ROUND(r.amount_15 - s.amount_15, @BasePrecision), r.total_amount = ROUND(r.total_amount - s.total_amount, @BasePrecision),
                     r.ProjCury_amount_01 = ROUND(r.ProjCury_amount_01 - s.ProjCury_amount_01, @ProjCuryPrecision), r.ProjCury_amount_02 = ROUND(r.ProjCury_amount_02 - s.ProjCury_amount_02, @ProjCuryPrecision),
                     r.ProjCury_amount_03 = ROUND(r.ProjCury_amount_03 - s.ProjCury_amount_03, @ProjCuryPrecision), r.ProjCury_amount_04 = ROUND(r.ProjCury_amount_04 - s.ProjCury_amount_04, @ProjCuryPrecision),
                     r.ProjCury_amount_05 = ROUND(r.ProjCury_amount_05 - s.ProjCury_amount_05, @ProjCuryPrecision), r.ProjCury_amount_06 = ROUND(r.ProjCury_amount_06 - s.ProjCury_amount_06, @ProjCuryPrecision),
                     r.ProjCury_amount_07 = ROUND(r.ProjCury_amount_07 - s.ProjCury_amount_07, @ProjCuryPrecision), r.ProjCury_amount_08 = ROUND(r.ProjCury_amount_08 - s.ProjCury_amount_08, @ProjCuryPrecision),
                     r.ProjCury_amount_09 = ROUND(r.ProjCury_amount_09 - s.ProjCury_amount_09, @ProjCuryPrecision), r.ProjCury_amount_10 = ROUND(r.ProjCury_amount_10 - s.ProjCury_amount_10, @ProjCuryPrecision),
                     r.ProjCury_amount_11 = ROUND(r.ProjCury_amount_11 - s.ProjCury_amount_11, @ProjCuryPrecision), r.ProjCury_amount_12 = ROUND(r.ProjCury_amount_12 - s.ProjCury_amount_12, @ProjCuryPrecision),
                     r.ProjCury_amount_13 = ROUND(r.ProjCury_amount_13 - s.ProjCury_amount_13, @ProjCuryPrecision), r.ProjCury_amount_14 = ROUND(r.ProjCury_amount_14 - s.ProjCury_amount_14, @ProjCuryPrecision),
                     r.ProjCury_amount_15 = ROUND(r.ProjCury_amount_15 - s.ProjCury_amount_15, @ProjCuryPrecision), r.ProjCury_total_amt = ROUND(r.ProjCury_total_amt - s.ProjCury_total_amt, @ProjCuryPrecision),
                     r.units_01 = ROUND(r.units_01 - s.units_01, @UnitPrecision), r.units_02 = ROUND(r.units_02 - s.units_02, @UnitPrecision),
                     r.units_03 = ROUND(r.units_03 - s.units_03, @UnitPrecision), r.units_04 = ROUND(r.units_04 - s.units_04, @UnitPrecision),
                     r.units_05 = ROUND(r.units_05 - s.units_05, @UnitPrecision), r.units_06 = ROUND(r.units_06 - s.units_06, @UnitPrecision),
                     r.units_07 = ROUND(r.units_07 - s.units_07, @UnitPrecision), r.units_08 = ROUND(r.units_08 - s.units_08, @UnitPrecision),
                     r.units_09 = ROUND(r.units_09 - s.units_09, @UnitPrecision), r.units_10 = ROUND(r.units_10 - s.units_10, @UnitPrecision),
                     r.units_11 = ROUND(r.units_11 - s.units_11, @UnitPrecision), r.units_12 = ROUND(r.units_12 - s.units_12, @UnitPrecision),
                     r.units_13 = ROUND(r.units_13 - s.units_13, @UnitPrecision), r.units_14 = ROUND(r.units_14 - s.units_14, @UnitPrecision), 
                     r.units_15 = ROUND(r.units_15 - s.units_15, @UnitPrecision), r.total_units = ROUND(r.total_units - s.total_units, @UnitPrecision)
               FROM PJBUDROL r JOIN PJBUDSUM s
                                 ON r.fsyear_num = s.fsyear_num
                                AND r.project = s.project
                                AND r.acct = s.acct
                                AND r.PlanNbr = s.planNbr
               WHERE s.fsyear_num = LEFT(@PJRevTimFicalNo,4)
                 AND s.project = @ProjectID
                 AND s.acct = @Acct
                 AND s.PlanNbr = '00'
                 AND s.pjt_entity = @TaskID
               IF @@ERROR <> 0
               BEGIN
                  CLOSE PJRevTim_Csr
                  DEALLOCATE PJRevTim_Csr
                  SET @ERRORNBR = 300
                  GOTO ABORT
               END
            End

            If @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
            Begin
               --Backout_PJBUDROL("  ")
               UPDATE r
               SET r.amount_01 = ROUND(r.amount_01 - s.amount_01, @BasePrecision), r.amount_02 = ROUND(r.amount_02 - s.amount_02, @BasePrecision),
                     r.amount_03 = ROUND(r.amount_03 - s.amount_03, @BasePrecision), r.amount_04 = ROUND(r.amount_04 - s.amount_04, @BasePrecision),
                     r.amount_05 = ROUND(r.amount_05 - s.amount_05, @BasePrecision), r.amount_06 = ROUND(r.amount_06 - s.amount_06, @BasePrecision),
                     r.amount_07 = ROUND(r.amount_07 - s.amount_07, @BasePrecision), r.amount_08 = ROUND(r.amount_08 - s.amount_08, @BasePrecision),
                     r.amount_09 = ROUND(r.amount_09 - s.amount_09, @BasePrecision), r.amount_10 = ROUND(r.amount_10 - s.amount_10, @BasePrecision),
                     r.amount_11 = ROUND(r.amount_11 - s.amount_11, @BasePrecision), r.amount_12 = ROUND(r.amount_12 - s.amount_12, @BasePrecision),
                     r.amount_13 = ROUND(r.amount_13 - s.amount_13, @BasePrecision), r.amount_14 = ROUND(r.amount_14 - s.amount_14, @BasePrecision),
                     r.amount_15 = ROUND(r.amount_15 - s.amount_15, @BasePrecision), r.total_amount = ROUND(r.total_amount - s.total_amount, @BasePrecision),
                     r.ProjCury_amount_01 = ROUND(r.ProjCury_amount_01 - s.ProjCury_amount_01, @ProjCuryPrecision), r.ProjCury_amount_02 = ROUND(r.ProjCury_amount_02 - s.ProjCury_amount_02, @ProjCuryPrecision),
                     r.ProjCury_amount_03 = ROUND(r.ProjCury_amount_03 - s.ProjCury_amount_03, @ProjCuryPrecision), r.ProjCury_amount_04 = ROUND(r.ProjCury_amount_04 - s.ProjCury_amount_04, @ProjCuryPrecision),
                     r.ProjCury_amount_05 = ROUND(r.ProjCury_amount_05 - s.ProjCury_amount_05, @ProjCuryPrecision), r.ProjCury_amount_06 = ROUND(r.ProjCury_amount_06 - s.ProjCury_amount_06, @ProjCuryPrecision),
                     r.ProjCury_amount_07 = ROUND(r.ProjCury_amount_07 - s.ProjCury_amount_07, @ProjCuryPrecision), r.ProjCury_amount_08 = ROUND(r.ProjCury_amount_08 - s.ProjCury_amount_08, @ProjCuryPrecision),
                     r.ProjCury_amount_09 = ROUND(r.ProjCury_amount_09 - s.ProjCury_amount_09, @ProjCuryPrecision), r.ProjCury_amount_10 = ROUND(r.ProjCury_amount_10 - s.ProjCury_amount_10, @ProjCuryPrecision),
                     r.ProjCury_amount_11 = ROUND(r.ProjCury_amount_11 - s.ProjCury_amount_11, @ProjCuryPrecision), r.ProjCury_amount_12 = ROUND(r.ProjCury_amount_12 - s.ProjCury_amount_12, @ProjCuryPrecision),
                     r.ProjCury_amount_13 = ROUND(r.ProjCury_amount_13 - s.ProjCury_amount_13, @ProjCuryPrecision), r.ProjCury_amount_14 = ROUND(r.ProjCury_amount_14 - s.ProjCury_amount_14, @ProjCuryPrecision),
                     r.ProjCury_amount_15 = ROUND(r.ProjCury_amount_15 - s.ProjCury_amount_15, @ProjCuryPrecision), r.ProjCury_total_amt = ROUND(r.ProjCury_total_amt - s.ProjCury_total_amt, @ProjCuryPrecision),
                     r.units_01 = ROUND(r.units_01 - s.units_01, @UnitPrecision), r.units_02 = ROUND(r.units_02 - s.units_02, @UnitPrecision),
                     r.units_03 = ROUND(r.units_03 - s.units_03, @UnitPrecision), r.units_04 = ROUND(r.units_04 - s.units_04, @UnitPrecision),
                     r.units_05 = ROUND(r.units_05 - s.units_05, @UnitPrecision), r.units_06 = ROUND(r.units_06 - s.units_06, @UnitPrecision),
                     r.units_07 = ROUND(r.units_07 - s.units_07, @UnitPrecision), r.units_08 = ROUND(r.units_08 - s.units_08, @UnitPrecision),
                     r.units_09 = ROUND(r.units_09 - s.units_09, @UnitPrecision), r.units_10 = ROUND(r.units_10 - s.units_10, @UnitPrecision),
                     r.units_11 = ROUND(r.units_11 - s.units_11, @UnitPrecision), r.units_12 = ROUND(r.units_12 - s.units_12, @UnitPrecision),
                     r.units_13 = ROUND(r.units_13 - s.units_13, @UnitPrecision), r.units_14 = ROUND(r.units_14 - s.units_14, @UnitPrecision),
                     r.units_15 = ROUND(r.units_15 - s.units_15, @UnitPrecision), r.total_units = ROUND(r.total_units - s.total_units, @UnitPrecision)
               FROM PJBUDROL r JOIN PJBUDSUM s
                                 ON r.fsyear_num = s.fsyear_num
                                AND r.project = s.project
                                AND r.acct = s.acct
                                AND r.PlanNbr = s.planNbr
               WHERE s.fsyear_num = LEFT(@PJRevTimFicalNo,4)
                 AND s.project = @ProjectID
                 AND s.acct = @Acct
                 AND s.PlanNbr = ' '
                 AND s.pjt_entity = @TaskID
               IF @@ERROR <> 0
               BEGIN
                  CLOSE PJRevTim_Csr
                  DEALLOCATE PJRevTim_Csr
                  SET @ERRORNBR = 300
                  GOTO ABORT
               END
            End
         end
      
         /**  INITIALIZE VARILBLES TO ZERO  **/   
         SET @TempPJBudSum_Amount01 = 0
         SET @TempPJBudSum_Amount02 = 0
         SET @TempPJBudSum_Amount03 = 0
         SET @TempPJBudSum_Amount04 = 0
         SET @TempPJBudSum_Amount05 = 0 
         SET @TempPJBudSum_Amount06 = 0
         SET @TempPJBudSum_Amount07 = 0
         SET @TempPJBudSum_Amount08 = 0
         SET @TempPJBudSum_Amount09 = 0
         SET @TempPJBudSum_Amount10 = 0
         SET @TempPJBudSum_Amount11 = 0
         SET @TempPJBudSum_Amount12 = 0
         SET @TempPJBudSum_Amount13 = 0
         SET @TempPJBudSum_Amount14 = 0
         SET @TempPJBudSum_Amount15 = 0  
         SET @TempPJBudSum_ProjCury_Amount01 = 0
         SET @TempPJBudSum_ProjCury_Amount02 = 0
         SET @TempPJBudSum_ProjCury_Amount03 = 0
         SET @TempPJBudSum_ProjCury_Amount04 = 0
         SET @TempPJBudSum_ProjCury_Amount05 = 0 
         SET @TempPJBudSum_ProjCury_Amount06 = 0
         SET @TempPJBudSum_ProjCury_Amount07 = 0
         SET @TempPJBudSum_ProjCury_Amount08 = 0
         SET @TempPJBudSum_ProjCury_Amount09 = 0
         SET @TempPJBudSum_ProjCury_Amount10 = 0
         SET @TempPJBudSum_ProjCury_Amount11 = 0
         SET @TempPJBudSum_ProjCury_Amount12 = 0
         SET @TempPJBudSum_ProjCury_Amount13 = 0
         SET @TempPJBudSum_ProjCury_Amount14 = 0
         SET @TempPJBudSum_ProjCury_Amount15 = 0  
         SET @TempPJBudSum_Units01 = 0
         SET @TempPJBudSum_Units02 = 0
         SET @TempPJBudSum_Units03 = 0
         SET @TempPJBudSum_Units04 = 0
         SET @TempPJBudSum_Units05 = 0 
         SET @TempPJBudSum_Units06 = 0
         SET @TempPJBudSum_Units07 = 0
         SET @TempPJBudSum_Units08 = 0
         SET @TempPJBudSum_Units09 = 0
         SET @TempPJBudSum_Units10 = 0
         SET @TempPJBudSum_Units11 = 0
         SET @TempPJBudSum_Units12 = 0
         SET @TempPJBudSum_Units13 = 0
         SET @TempPJBudSum_Units14 = 0
         SET @TempPJBudSum_Units15 = 0
         SET @Total_Amount = 0
         SET @ProjCury_Total_Amount = 0
         SET @Total_Units = 0        
         SET @First_record = 'FALS'
      END                           --If LEFT(@PJRevTimFicalNo,4) <> @prev_fsyear_num OR @First_record = 'TRUE'
      
     SET @Total_Amount = ROUND(@Total_Amount + @PJRevTimAmount, @BasePrecision)
     SET @ProjCury_Total_Amount = ROUND(@ProjCury_Total_Amount + @PJRevTimProjCuryAmount, @ProjCuryPrecision)
     SET @Total_Units = ROUND(@Total_Units + @RPJRevTimUnits, @UnitPrecision)
     
     SET @TempPJBudSum_fsyear_num = LEFT(@PJRevTimFicalNo,4)

     IF RIGHT(@PJRevTimFicalNo, 2) = '01'
      BEGIN
       SET @TempPJBudSum_Amount01 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount01 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units01 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '02'
      BEGIN
       SET @TempPJBudSum_Amount02 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount02 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units02 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '03'
      BEGIN
       SET @TempPJBudSum_Amount03 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount03 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units03 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '04'
      BEGIN
       SET @TempPJBudSum_Amount04 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount04 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units04 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '05'
      BEGIN
       SET @TempPJBudSum_Amount05 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount05 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units05 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '06'
      BEGIN
       SET @TempPJBudSum_Amount06 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount06 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units06 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '07'
      BEGIN
       SET @TempPJBudSum_Amount07 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount07 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units07 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '08'
      BEGIN
       SET @TempPJBudSum_Amount08 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount08 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units08 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '09'
      BEGIN
       SET @TempPJBudSum_Amount09 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount09 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units09 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '10'
      BEGIN
       SET @TempPJBudSum_Amount10 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount10 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units10 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '11'
      BEGIN
       SET @TempPJBudSum_Amount11 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount11 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units11 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '12'
      BEGIN
       SET @TempPJBudSum_Amount12 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount12 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units12 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '13'
      BEGIN
       SET @TempPJBudSum_Amount13 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount13 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units13 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '14'
      BEGIN
       SET @TempPJBudSum_Amount14 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount14 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units14 = @RPJRevTimUnits
      END
     ELSE IF RIGHT(@PJRevTimFicalNo, 2) = '15'
      BEGIN
       SET @TempPJBudSum_Amount15 = @PJRevTimAmount
       SET @TempPJBudSum_ProjCury_Amount15 = @PJRevTimProjCuryAmount
       SET @TempPJBudSum_Units15 = @RPJRevTimUnits
      END

     SET @prev_fsyear_num = LEFT(@PJRevTimFicalNo,4)

      -- get next record, if any, and loop.
      FETCH PJRevTim_Csr INTO @PJRevTimFicalNo, @PJRevTimAmount, @PJRevTimProjCuryAmount, @RPJRevTimUnits, @PJREVTimRate, @PJREVTimProjCuryRate
      IF @@ERROR <> 0
      BEGIN
         CLOSE PJRevTim_Csr
         DEALLOCATE PJRevTim_Csr
         SET @ERRORNBR = 200
         GOTO ABORT
      END
   END   -- END of WHILE @@FETCH_STATUS = 0 for PJREVCAT

 CLOSE PJRevTim_Csr
 DEALLOCATE PJRevTim_Csr

IF @First_record <> 'TRUE'
BEGIN
    If @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
    Begin
         --Update_PJBUDSUM_AND_ROL("00")
         EXEC UPDATE_PJBUDSUMBUDROL @TempPJBudSum_fsyear_num, @ProjectID, @TaskID, @RevId, @Acct, '00',
                    @UserID, @ProgID, @RevisionType, @PJREVTimRate, @PJREVTimProjCuryRate , @Total_Amount, @ProjCury_Total_Amount, @Total_Units,
                    @TempPJBudSum_Amount01, @TempPJBudSum_Amount02, @TempPJBudSum_Amount03,
                    @TempPJBudSum_Amount04, @TempPJBudSum_Amount05, @TempPJBudSum_Amount06,
                    @TempPJBudSum_Amount07, @TempPJBudSum_Amount08, @TempPJBudSum_Amount09,
                    @TempPJBudSum_Amount10, @TempPJBudSum_Amount11, @TempPJBudSum_Amount12,
                    @TempPJBudSum_Amount13, @TempPJBudSum_Amount14, @TempPJBudSum_Amount15,
                    @TempPJBudSum_ProjCury_Amount01, @TempPJBudSum_ProjCury_Amount02, @TempPJBudSum_ProjCury_Amount03,
                    @TempPJBudSum_ProjCury_Amount04, @TempPJBudSum_ProjCury_Amount05, @TempPJBudSum_ProjCury_Amount06,
                    @TempPJBudSum_ProjCury_Amount07, @TempPJBudSum_ProjCury_Amount08, @TempPJBudSum_ProjCury_Amount09,
                    @TempPJBudSum_ProjCury_Amount10, @TempPJBudSum_ProjCury_Amount11, @TempPJBudSum_ProjCury_Amount12,
                    @TempPJBudSum_ProjCury_Amount13, @TempPJBudSum_ProjCury_Amount14, @TempPJBudSum_ProjCury_Amount15,
                    @TempPJBudSum_Units01, @TempPJBudSum_Units02, @TempPJBudSum_Units03,
                    @TempPJBudSum_Units04, @TempPJBudSum_Units05, @TempPJBudSum_Units06,
                    @TempPJBudSum_Units07, @TempPJBudSum_Units08, @TempPJBudSum_Units09,
                    @TempPJBudSum_Units10, @TempPJBudSum_Units11, @TempPJBudSum_Units12,
                    @TempPJBudSum_Units13, @TempPJBudSum_Units14, @TempPJBudSum_Units15,
                    @BasePrecision, @ProjCuryPrecision, @UnitPrecision, @PPResult OUTPUT
         IF @PPResult <> 0
         BEGIN
            -- 2000 - PJBUDSUM
            -- 3000 - PJBUDROL
            -- 4000 - PJBUDSUM Future Summary
            -- 5000 - PJBUDROL Future Summary
            SET @ERRORNBR = @PPResult
            GOTO ABORT
         END
    End

    If @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
    Begin
         -- Update_PJBUDSUM_AND_ROL("  ")
         EXEC UPDATE_PJBUDSUMBUDROL @TempPJBudSum_fsyear_num, @ProjectID, @TaskID, @RevId, @Acct, ' ',
                    @UserID, @ProgID, @RevisionType, @PJREVTimRate, @PJREVTimProjCuryRate, @Total_Amount, @ProjCury_Total_Amount, @Total_Units,
                    @TempPJBudSum_Amount01, @TempPJBudSum_Amount02, @TempPJBudSum_Amount03,
                    @TempPJBudSum_Amount04, @TempPJBudSum_Amount05, @TempPJBudSum_Amount06,
                    @TempPJBudSum_Amount07, @TempPJBudSum_Amount08, @TempPJBudSum_Amount09,
                    @TempPJBudSum_Amount10, @TempPJBudSum_Amount11, @TempPJBudSum_Amount12,
                    @TempPJBudSum_Amount13, @TempPJBudSum_Amount14, @TempPJBudSum_Amount15,
                    @TempPJBudSum_ProjCury_Amount01, @TempPJBudSum_ProjCury_Amount02, @TempPJBudSum_ProjCury_Amount03,
                    @TempPJBudSum_ProjCury_Amount04, @TempPJBudSum_ProjCury_Amount05, @TempPJBudSum_ProjCury_Amount06,
                    @TempPJBudSum_ProjCury_Amount07, @TempPJBudSum_ProjCury_Amount08, @TempPJBudSum_ProjCury_Amount09,
                    @TempPJBudSum_ProjCury_Amount10, @TempPJBudSum_ProjCury_Amount11, @TempPJBudSum_ProjCury_Amount12,
                    @TempPJBudSum_ProjCury_Amount13, @TempPJBudSum_ProjCury_Amount14, @TempPJBudSum_ProjCury_Amount15,
                    @TempPJBudSum_Units01, @TempPJBudSum_Units02, @TempPJBudSum_Units03, 
                    @TempPJBudSum_Units04, @TempPJBudSum_Units05, @TempPJBudSum_Units06, 
                    @TempPJBudSum_Units07, @TempPJBudSum_Units08, @TempPJBudSum_Units09, 
                    @TempPJBudSum_Units10, @TempPJBudSum_Units11, @TempPJBudSum_Units12, 
                    @TempPJBudSum_Units13, @TempPJBudSum_Units14, @TempPJBudSum_Units15,
                    @BasePrecision, @ProjCuryPrecision, @UnitPrecision, @PPResult OUTPUT
        IF @PPResult <> 0
        BEGIN
            -- 2000 - PJBUDSUM
            -- 3000 - PJBUDROL
            -- 4000 - PJBUDSUM Future Summary
            -- 5000 - PJBUDROL Future Summary
           SET @ERRORNBR = @PPResult
           GOTO ABORT
        END
    End
END                                    

SELECT @PPResult = 0
GOTO FINISH

ABORT:
/**
  @ERRORNBR Values.
  200 - PJREVTIM
  300 - PJBUDROL Backout

  2000 - PJBUDSUM
  3000 - PJBUDROL
  4000 - PJBUDSUM Future Summary
  5000 - PJBUDROL Future Summary
**/
SELECT @PPResult = @ERRORNBR

FINISH:

