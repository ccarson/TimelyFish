 
CREATE PROCEDURE UPDATE_PJBUDSUMBUDROL @fsyear_num VarChar(4), @project VarChar(16), @pjt_entity VarChar(32), @revId VarChar(4), @acct VarChar(16), @planNbr VarChar(2),
                                 @UserID VarChar(10), @ProgID VarChar(8), @RevisionType VarChar(2), @Rate FLOAT, @ProjCury_Rate FLOAT, @total_amount FLOAT, @ProjCury_total_amt FLOAT, @total_units FLOAT,
                                 @Amount01 FLOAT, @Amount02 FLOAT, @Amount03 FLOAT, @Amount04 FLOAT, @Amount05 FLOAT, @Amount06 FLOAT, @Amount07 FLOAT, @Amount08 FLOAT,
                                 @Amount09 FLOAT, @Amount10 FLOAT, @Amount11 FLOAT, @Amount12 FLOAT, @Amount13 FLOAT, @Amount14 FLOAT, @Amount15 FLOAT,
                                 @ProjCuryAmount01 FLOAT, @ProjCuryAmount02 FLOAT, @ProjCuryAmount03 FLOAT, @ProjCuryAmount04 FLOAT, @ProjCuryAmount05 FLOAT, @ProjCuryAmount06 FLOAT, @ProjCuryAmount07 FLOAT, @ProjCuryAmount08 FLOAT,
                                 @ProjCuryAmount09 FLOAT, @ProjCuryAmount10 FLOAT, @ProjCuryAmount11 FLOAT, @ProjCuryAmount12 FLOAT, @ProjCuryAmount13 FLOAT, @ProjCuryAmount14 FLOAT, @ProjCuryAmount15 FLOAT,
                                 @Units01 FLOAT, @Units02 FLOAT, @Units03 FLOAT, @Units04 FLOAT, @Units05 FLOAT, @Units06 FLOAT, @Units07 FLOAT, @Units08 FLOAT,
                                 @Units09 FLOAT, @Units10 FLOAT, @Units11 FLOAT, @Units12 FLOAT, @Units13 FLOAT, @Units14 FLOAT, @Units15 FLOAT, @BasePrecision INT, @ProjCuryPrecision INT, @UnitPrecision INT, @PPResult INT OUTPUT
AS

 DECLARE @Prev_fsyear VarChar(4) = ''
 DECLARE @Next_fsyear VarChar(4) = ''
 DECLARE @PJBUDSUM_amount_bf FLOAT
 DECLARE @PJBUDSUM_ProjCury_amount_bf FLOAT
 DECLARE @PJBUDSUM_units_bf FLOAT
 DECLARE @PJBUDSUM_total_amount FLOAT
 DECLARE @PJBUDSUM_ProjCury_total_amt FLOAT
 DECLARE @PJBUDSUM_total_units FLOAT
 DECLARE @PJBUDROL_amount_bf FLOAT
 DECLARE @PJBUDROL_ProjCury_amount_bf FLOAT
 DECLARE @PJBUDROL_units_bf FLOAT
 DECLARE @PJBUDROL_total_amount FLOAT
 DECLARE @PJBUDROL_ProjCury_total_amt FLOAT
 DECLARE @PJBUDROL_total_units FLOAT
 DECLARE @tamt FLOAT
 DECLARE @ProjCurytamt FLOAT
 DECLARE @tunt FLOAT
 DECLARE @ERRORNBR INT

 IF (SELECT project from PJBUDSUM WHERE fsyear_num = @fsyear_num and project = @project and pjt_entity = @pjt_entity and acct = @acct and planNbr = @planNbr) is null
 BEGIN
    -- Previous Year Information.
    SET @Prev_fsyear = CAST((CAST(@fsyear_num AS INT) - 1) AS VARCHAR(4))

    SELECT @PJBUDSUM_amount_bf = ROUND(ISNULL(amount_bf,0) + ISNULL(total_amount,0),@BasePrecision),
           @PJBUDSUM_ProjCury_amount_bf = ROUND(ISNULL(ProjCury_amount_bf,0) + ISNULL(ProjCury_total_amt,0),@ProjCuryPrecision),
           @PJBUDSUM_units_bf = ROUND(ISNULL(units_bf,0) + ISNULL(total_units,0),@UnitPrecision)
      FROM PJBUDSUM
     WHERE fsyear_num = @Prev_fsyear
       AND project = @project
       AND pjt_entity = @pjt_entity
       AND Acct = @acct
       AND planNbr = @planNbr
    IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 2000
       GOTO ABORT
    END

    INSERT PJBUDSUM (acct, amount_01, amount_02, amount_03, amount_04,
            amount_05, amount_06, amount_07, amount_08, amount_09,
            amount_10, amount_11, amount_12, amount_13, amount_14,
            amount_15, amount_bf, crtd_datetime, crtd_prog, crtd_user,
            data1, fsyear_num, lupd_datetime, lupd_prog, lupd_user,
            pjt_entity, planNbr, ProjCury_amount_01, ProjCury_amount_02,
            ProjCury_amount_03, ProjCury_amount_04, ProjCury_amount_05,
            ProjCury_amount_06, ProjCury_amount_07, ProjCury_amount_08,
            ProjCury_amount_09, ProjCury_amount_10, ProjCury_amount_11,
            ProjCury_amount_12, ProjCury_amount_13, ProjCury_amount_14,
            ProjCury_amount_15, ProjCury_amount_bf, ProjCury_Rate,
            ProjCury_total_amt, project, rate, total_amount,
            total_units, units_01, units_02, units_03, units_04,
            units_05, units_06, units_07, units_08, units_09,
            units_10, units_11, units_12, units_13, units_14,
            units_15, units_bf)
    SELECT @acct, @Amount01, @Amount02, @Amount03, @Amount04,
            @Amount05, @Amount06, @Amount07, @Amount08, @Amount09,
            @Amount10, @Amount11, @Amount12, @Amount13, @Amount14,
            @Amount15, ISNULL(@PJBUDSUM_amount_bf,0), GETDATE(), @ProgID, @UserID,
            '', @fsyear_num, GETDATE(), @ProgID, @UserID,
            @pjt_entity, @planNbr, @ProjCuryAmount01, @ProjCuryAmount02,
            @ProjCuryAmount03, @ProjCuryAmount04, @ProjCuryAmount05,
            @ProjCuryAmount06, @ProjCuryAmount07, @ProjCuryAmount08,
            @ProjCuryAmount09, @ProjCuryAmount10, @ProjCuryAmount11,
            @ProjCuryAmount12, @ProjCuryAmount13, @ProjCuryAmount14,
            @ProjCuryAmount15, ISNULL(@PJBUDSUM_ProjCury_amount_bf,0), @ProjCury_Rate,
            @ProjCury_total_amt, @project, @Rate, @total_amount,
            @total_units, @Units01, @Units02, @Units03, @Units04,
            @Units05, @Units06, @Units07, @Units08, @Units09,
            @Units10, @Units11, @Units12, @Units13, @Units14,
            @Units15, ISNULL(@PJBUDSUM_units_bf,0) 
    IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 2000
       GOTO ABORT
    END
 END
 ELSE
 BEGIN
    UPDATE PJBUDSUM
       SET amount_01 = CASE WHEN @RevisionType <> 'NT' THEN @Amount01 ELSE ROUND(amount_01 + @Amount01, @BasePrecision) END,
            amount_02 = CASE WHEN @RevisionType <> 'NT' THEN @Amount02 ELSE ROUND(amount_02 + @Amount02, @BasePrecision) END,
            amount_03 = CASE WHEN @RevisionType <> 'NT' THEN @Amount03 ELSE ROUND(amount_03 + @Amount03, @BasePrecision) END,
            amount_04 = CASE WHEN @RevisionType <> 'NT' THEN @Amount04 ELSE ROUND(amount_04 + @Amount04, @BasePrecision) END,
            amount_05 = CASE WHEN @RevisionType <> 'NT' THEN @Amount05 ELSE ROUND(amount_05 + @Amount05, @BasePrecision) END,
            amount_06 = CASE WHEN @RevisionType <> 'NT' THEN @Amount06 ELSE ROUND(amount_06 + @Amount06, @BasePrecision) END,
            amount_07 = CASE WHEN @RevisionType <> 'NT' THEN @Amount07 ELSE ROUND(amount_07 + @Amount07, @BasePrecision) END,
            amount_08 = CASE WHEN @RevisionType <> 'NT' THEN @Amount08 ELSE ROUND(amount_08 + @Amount08, @BasePrecision) END,
            amount_09 = CASE WHEN @RevisionType <> 'NT' THEN @Amount09 ELSE ROUND(amount_09 + @Amount09, @BasePrecision) END,
            amount_10 = CASE WHEN @RevisionType <> 'NT' THEN @Amount10 ELSE ROUND(amount_10 + @Amount10, @BasePrecision) END,
            amount_11 = CASE WHEN @RevisionType <> 'NT' THEN @Amount11 ELSE ROUND(amount_11 + @Amount11, @BasePrecision) END,
            amount_12 = CASE WHEN @RevisionType <> 'NT' THEN @Amount12 ELSE ROUND(amount_12 + @Amount12, @BasePrecision) END,
            amount_13 = CASE WHEN @RevisionType <> 'NT' THEN @Amount13 ELSE ROUND(amount_13 + @Amount13, @BasePrecision) END,
            amount_14 = CASE WHEN @RevisionType <> 'NT' THEN @Amount14 ELSE ROUND(amount_14 + @Amount14, @BasePrecision) END,
            amount_15 = CASE WHEN @RevisionType <> 'NT' THEN @Amount15 ELSE ROUND(amount_15 + @Amount15, @BasePrecision) END,
            ProjCury_amount_01 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount01 ELSE ROUND(ProjCury_amount_01 + @ProjCuryAmount01, @ProjCuryPrecision) END,
            ProjCury_amount_02 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount02 ELSE ROUND(ProjCury_amount_02 + @ProjCuryAmount02, @ProjCuryPrecision) END,
            ProjCury_amount_03 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount03 ELSE ROUND(ProjCury_amount_03 + @ProjCuryAmount03, @ProjCuryPrecision) END,
            ProjCury_amount_04 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount04 ELSE ROUND(ProjCury_amount_04 + @ProjCuryAmount04, @ProjCuryPrecision) END,
            ProjCury_amount_05 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount05 ELSE ROUND(ProjCury_amount_05 + @ProjCuryAmount05, @ProjCuryPrecision) END,
            ProjCury_amount_06 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount06 ELSE ROUND(ProjCury_amount_06 + @ProjCuryAmount06, @ProjCuryPrecision) END,
            ProjCury_amount_07 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount07 ELSE ROUND(ProjCury_amount_07 + @ProjCuryAmount07, @ProjCuryPrecision) END,
            ProjCury_amount_08 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount08 ELSE ROUND(ProjCury_amount_08 + @ProjCuryAmount08, @ProjCuryPrecision) END,
            ProjCury_amount_09 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount09 ELSE ROUND(ProjCury_amount_09 + @ProjCuryAmount09, @ProjCuryPrecision) END,
            ProjCury_amount_10 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount10 ELSE ROUND(ProjCury_amount_10 + @ProjCuryAmount10, @ProjCuryPrecision) END,
            ProjCury_amount_11 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount11 ELSE ROUND(ProjCury_amount_11 + @ProjCuryAmount11, @ProjCuryPrecision) END,
            ProjCury_amount_12 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount12 ELSE ROUND(ProjCury_amount_12 + @ProjCuryAmount12, @ProjCuryPrecision) END,
            ProjCury_amount_13 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount13 ELSE ROUND(ProjCury_amount_13 + @ProjCuryAmount13, @ProjCuryPrecision) END,
            ProjCury_amount_14 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount14 ELSE ROUND(ProjCury_amount_14 + @ProjCuryAmount14, @ProjCuryPrecision) END,
            ProjCury_amount_15 = CASE WHEN @RevisionType <> 'NT' THEN @ProjCuryAmount15 ELSE ROUND(ProjCury_amount_15 + @ProjCuryAmount15, @ProjCuryPrecision) END,
            units_01 = CASE WHEN @RevisionType <> 'NT' THEN @Units01 ELSE ROUND(units_01 + @Units01, @UnitPrecision) END,
            units_02 = CASE WHEN @RevisionType <> 'NT' THEN @Units02 ELSE ROUND(units_02 + @Units02, @UnitPrecision) END,
            units_03 = CASE WHEN @RevisionType <> 'NT' THEN @Units03 ELSE ROUND(units_03 + @Units03, @UnitPrecision) END,
            units_04 = CASE WHEN @RevisionType <> 'NT' THEN @Units04 ELSE ROUND(units_04 + @Units04, @UnitPrecision) END,
            units_05 = CASE WHEN @RevisionType <> 'NT' THEN @Units05 ELSE ROUND(units_05 + @Units05, @UnitPrecision) END,
            units_06 = CASE WHEN @RevisionType <> 'NT' THEN @Units06 ELSE ROUND(units_06 + @Units06, @UnitPrecision) END,
            units_07 = CASE WHEN @RevisionType <> 'NT' THEN @Units07 ELSE ROUND(units_07 + @Units07, @UnitPrecision) END,
            units_08 = CASE WHEN @RevisionType <> 'NT' THEN @Units08 ELSE ROUND(units_08 + @Units08, @UnitPrecision) END,
            units_09 = CASE WHEN @RevisionType <> 'NT' THEN @Units09 ELSE ROUND(units_09 + @Units09, @UnitPrecision) END,
            units_10 = CASE WHEN @RevisionType <> 'NT' THEN @Units10 ELSE ROUND(units_10 + @Units10, @UnitPrecision) END,
            units_11 = CASE WHEN @RevisionType <> 'NT' THEN @Units11 ELSE ROUND(units_11 + @Units11, @UnitPrecision) END,
            units_12 = CASE WHEN @RevisionType <> 'NT' THEN @Units12 ELSE ROUND(units_12 + @Units12, @UnitPrecision) END,
            units_13 = CASE WHEN @RevisionType <> 'NT' THEN @Units13 ELSE ROUND(units_13 + @Units13, @UnitPrecision) END,
            units_14 = CASE WHEN @RevisionType <> 'NT' THEN @Units14 ELSE ROUND(units_14 + @Units14, @UnitPrecision) END,
            units_15 = CASE WHEN @RevisionType <> 'NT' THEN @Units15 ELSE ROUND(units_15 + @Units15, @UnitPrecision) END,
            total_amount = CASE WHEN @RevisionType <> 'NT' THEN @total_amount ELSE ROUND(total_amount + @total_amount, @BasePrecision) END,
            ProjCury_total_amt = CASE WHEN @RevisionType <> 'NT' THEN @ProjCury_total_amt ELSE ROUND(ProjCury_total_amt + @ProjCury_total_amt, @ProjCuryPrecision) END,
            total_units = CASE WHEN @RevisionType <> 'NT' THEN @total_units ELSE ROUND(total_units + @total_units, @UnitPrecision) END,
            lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
     WHERE fsyear_num = @fsyear_num
       AND project = @project
       AND pjt_entity = @pjt_entity
       AND Acct = @acct
       AND planNbr = @planNbr
    IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 2000
       GOTO ABORT
    END
 END

 IF (SELECT project FROM PJBUDROL WHERE fsyear_num = @fsyear_num AND project = @project AND acct = @acct AND planNbr = @planNbr) is null
 BEGIN
    -- Previous Year Information.
    SET @Prev_fsyear = CAST((CAST(@fsyear_num AS INT) - 1) AS VARCHAR(4))

    SELECT @PJBUDROL_amount_bf = ROUND(ISNULL(amount_bf,0) + ISNULL(total_amount,0),@BasePrecision),
           @PJBUDROL_ProjCury_amount_bf = ROUND(ISNULL(ProjCury_amount_bf,0) + ISNULL(ProjCury_total_amt,0),@ProjCuryPrecision),
           @PJBUDROL_units_bf = ROUND(ISNULL(units_bf,0) + ISNULL(total_units,0),@UnitPrecision)
      FROM PJBUDROL
     WHERE fsyear_num = @Prev_fsyear
       AND project = @project
       AND Acct = @acct
       AND planNbr = @planNbr
    IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 3000
       GOTO ABORT
    END

	INSERT PJBUDROL (acct, amount_01, amount_02, amount_03, amount_04,
            amount_05, amount_06, amount_07, amount_08, amount_09,
            amount_10, amount_11, amount_12, amount_13, amount_14,
            amount_15, amount_bf, crtd_datetime, crtd_prog, crtd_user,
            data1, fsyear_num, lupd_datetime, lupd_prog, lupd_user,
            PlanNbr, ProjCury_amount_01, ProjCury_amount_02,
            ProjCury_amount_03, ProjCury_amount_04, ProjCury_amount_05,
            ProjCury_amount_06, ProjCury_amount_07, ProjCury_amount_08,
            ProjCury_amount_09, ProjCury_amount_10, ProjCury_amount_11,
            ProjCury_amount_12, ProjCury_amount_13, ProjCury_amount_14,
            ProjCury_amount_15, ProjCury_amount_bf, ProjCury_total_amt, 
            project, total_amount, total_units, units_01,
            units_02, units_03, units_04, units_05, units_06,
            units_07, units_08, units_09, units_10, units_11,
            units_12, units_13, units_14, units_15, units_bf)
    SELECT @acct, @Amount01, @Amount02, @Amount03, @Amount04,
            @Amount05, @Amount06, @Amount07, @Amount08, @Amount09,
            @Amount10, @Amount11, @Amount12, @Amount13, @Amount14,
            @Amount15, ISNULL(@PJBUDROL_amount_bf,0), GETDATE(), @ProgID, @UserID,
            '', @fsyear_num, GETDATE(), @ProgID, @UserID,
            @planNbr, @ProjCuryAmount01, @ProjCuryAmount02,
            @ProjCuryAmount03, @ProjCuryAmount04, @ProjCuryAmount05,
            @ProjCuryAmount06, @ProjCuryAmount07, @ProjCuryAmount08,
            @ProjCuryAmount09, @ProjCuryAmount10, @ProjCuryAmount11,
            @ProjCuryAmount12, @ProjCuryAmount13, @ProjCuryAmount14,
            @ProjCuryAmount15, ISNULL(@PJBUDROL_ProjCury_amount_bf,0), @ProjCury_total_amt,
            @project, @total_amount, @total_units, @Units01,
            @Units02, @Units03, @Units04, @Units05, @Units06,
            @Units07, @Units08, @Units09, @Units10, @Units11,
            @Units12, @Units13, @Units14, @Units15, ISNULL(@PJBUDROL_units_bf,0)
    IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 3000
       GOTO ABORT
    END
 END
 ELSE
 BEGIN
    UPDATE PJBUDROL
       SET amount_01 = ROUND(amount_01 + @Amount01, @BasePrecision), amount_02 = ROUND(amount_02 + @Amount02, @BasePrecision),
            amount_03 = ROUND(amount_03 + @Amount03, @BasePrecision), amount_04 = ROUND(amount_04 + @Amount04, @BasePrecision),
            amount_05 = ROUND(amount_05 + @Amount05, @BasePrecision), amount_06 = ROUND(amount_06 + @Amount06, @BasePrecision),
            amount_07 = ROUND(amount_07 + @Amount07, @BasePrecision), amount_08 = ROUND(amount_08 + @Amount08, @BasePrecision),
            amount_09 = ROUND(amount_09 + @Amount09, @BasePrecision), amount_10 = ROUND(amount_10 + @Amount10, @BasePrecision),
            amount_11 = ROUND(amount_11 + @Amount11, @BasePrecision), amount_12 = ROUND(amount_12 + @Amount12, @BasePrecision),
            amount_13 = ROUND(amount_13 + @Amount13, @BasePrecision), amount_14 = ROUND(amount_14 + @Amount14, @BasePrecision),
            amount_15 = ROUND(amount_15 + @Amount15, @BasePrecision),
            ProjCury_amount_01 = ROUND(ProjCury_amount_01 + @ProjCuryAmount01, @ProjCuryPrecision), ProjCury_amount_02 = ROUND(ProjCury_amount_02 + @ProjCuryAmount02, @ProjCuryPrecision),
            ProjCury_amount_03 = ROUND(ProjCury_amount_03 + @ProjCuryAmount03, @ProjCuryPrecision), ProjCury_amount_04 = ROUND(ProjCury_amount_04 + @ProjCuryAmount04, @ProjCuryPrecision),
            ProjCury_amount_05 = ROUND(ProjCury_amount_05 + @ProjCuryAmount05, @ProjCuryPrecision), ProjCury_amount_06 = ROUND(ProjCury_amount_06 + @ProjCuryAmount06, @ProjCuryPrecision),
            ProjCury_amount_07 = ROUND(ProjCury_amount_07 + @ProjCuryAmount07, @ProjCuryPrecision), ProjCury_amount_08 = ROUND(ProjCury_amount_08 + @ProjCuryAmount08, @ProjCuryPrecision),
            ProjCury_amount_09 = ROUND(ProjCury_amount_09 + @ProjCuryAmount09, @ProjCuryPrecision), ProjCury_amount_10 = ROUND(ProjCury_amount_10 + @ProjCuryAmount10, @ProjCuryPrecision),
            ProjCury_amount_11 = ROUND(ProjCury_amount_11 + @ProjCuryAmount11, @ProjCuryPrecision), ProjCury_amount_12 = ROUND(ProjCury_amount_12 + @ProjCuryAmount12, @ProjCuryPrecision),
            ProjCury_amount_13 = ROUND(ProjCury_amount_13 + @ProjCuryAmount13, @ProjCuryPrecision), ProjCury_amount_14 = ROUND(ProjCury_amount_14 + @ProjCuryAmount14, @ProjCuryPrecision),
            ProjCury_amount_15 = ROUND(ProjCury_amount_15 + @ProjCuryAmount15, @ProjCuryPrecision),
            units_01 = ROUND(units_01 + @Units01, @UnitPrecision), units_02 = ROUND(units_02 + @Units02, @UnitPrecision),
            units_03 = ROUND(units_03 + @Units03, @UnitPrecision), units_04 = ROUND(units_04 + @Units04, @UnitPrecision),
            units_05 = ROUND(units_05 + @Units05, @UnitPrecision), units_06 = ROUND(units_06 + @Units06, @UnitPrecision),
            units_07 = ROUND(units_07 + @Units07, @UnitPrecision), units_08 = ROUND(units_08 + @Units08, @UnitPrecision),
            units_09 = ROUND(units_09 + @Units09, @UnitPrecision), units_10 = ROUND(units_10 + @Units10, @UnitPrecision),
            units_11 = ROUND(units_11 + @Units11, @UnitPrecision), units_12 = ROUND(units_12 + @Units12, @UnitPrecision),
            units_13 = ROUND(units_13 + @Units13, @UnitPrecision), units_14 = ROUND(units_14 + @Units14, @UnitPrecision),
            units_15 = ROUND(units_15 + @Units15, @UnitPrecision),
            total_amount = ROUND(total_amount + @total_amount, @BasePrecision),
            ProjCury_total_amt = ROUND(ProjCury_total_amt + @ProjCury_total_amt, @ProjCuryPrecision),
            total_units = ROUND(total_units + @total_units, @UnitPrecision),
            lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
     WHERE fsyear_num = @fsyear_num
       AND project = @project
       AND Acct = @acct
       AND planNbr = @planNbr
    IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 3000
       GOTO ABORT
    END
 END
 
 --Update Future Summary
 SELECT @PJBUDSUM_amount_bf = amount_bf, @PJBUDSUM_ProjCury_amount_bf = ProjCury_amount_bf,
        @PJBUDSUM_total_amount = total_amount, @PJBUDSUM_ProjCury_total_amt = ProjCury_total_amt,
        @PJBUDSUM_units_bf = units_bf,
        @PJBUDSUM_total_units = total_units
   FROM PJBUDSUM
  WHERE fsyear_num = @fsyear_num
    AND project = @project
    AND pjt_entity = @pjt_entity
    AND Acct = @acct
    AND planNbr = @planNbr
  IF @@ERROR <> 0
  BEGIN
     SET @ERRORNBR = 4000
     GOTO ABORT
  END
 
 SET @tamt = ROUND(@PJBUDSUM_amount_bf + @PJBUDSUM_total_amount, @BasePrecision)
 SET @ProjCurytamt = ROUND(@PJBUDSUM_ProjCury_amount_bf + @PJBUDSUM_ProjCury_total_amt, @ProjCuryPrecision)
 SET @tunt = ROUND(@PJBUDSUM_units_bf + @PJBUDSUM_total_units, @UnitPrecision)
 
 DECLARE PJBUDSUM_Csr INSENSITIVE CURSOR FOR
  SELECT fsyear_num, total_amount, ProjCury_total_amt, total_units
    FROM PJBUDSUM 
   WHERE fsyear_num > @fsyear_num
     AND project = @project
     AND pjt_entity = @pjt_entity
     AND Acct = @acct
     AND planNbr = @planNbr
   ORDER BY PJBUDSUM.fsyear_num, PJBUDSUM.project, PJBUDSUM.pjt_entity, PJBUDSUM.acct, PJBUDSUM.planNbr

    OPEN PJBUDSUM_Csr
   FETCH PJBUDSUM_Csr INTO @Next_fsyear, @PJBUDSUM_total_amount, @PJBUDSUM_ProjCury_total_amt, @PJBUDSUM_total_units
   IF @@ERROR <> 0
   BEGIN
      CLOSE PJBUDSUM_Csr
      DEALLOCATE PJBUDSUM_Csr
      SET @ERRORNBR = 4000
      GOTO ABORT
   END

 WHILE @@FETCH_STATUS = 0
 BEGIN
    --PRINT 'Balance Forward Amount = '  + CAST(@tamt AS VARCHAR(25)) + ' For Fiscal Year ' + @Next_fsyear   
    UPDATE PJBUDSUM 
       SET amount_bf = @tamt, ProjCury_amount_bf = @ProjCurytamt, units_bf = @tunt, lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
     WHERE fsyear_num = @Next_fsyear
       AND project = @project
       AND pjt_entity = @pjt_entity
       AND Acct = @acct
       AND planNbr = @planNbr
    IF @@ERROR <> 0
    BEGIN
       CLOSE PJBUDSUM_Csr
       DEALLOCATE PJBUDSUM_Csr
       SET @ERRORNBR = 4000
      GOTO ABORT
    END

    SET @tamt = ROUND(@tamt + @PJBUDSUM_total_amount, @BasePrecision)
    SET @ProjCurytamt = ROUND(@ProjCurytamt + @PJBUDSUM_ProjCury_total_amt, @ProjCuryPrecision)
    SET @tunt = ROUND(@tunt + @PJBUDSUM_total_units, @UnitPrecision)

    -- get next record, if any, and loop.
    FETCH PJBUDSUM_Csr INTO @Next_fsyear, @PJBUDSUM_total_amount, @PJBUDSUM_ProjCury_total_amt, @PJBUDSUM_total_units
    IF @@ERROR <> 0
    BEGIN
       CLOSE PJBUDSUM_Csr
       DEALLOCATE PJBUDSUM_Csr
       SET @ERRORNBR = 4000
       GOTO ABORT
    END
 END

 CLOSE PJBUDSUM_Csr
 DEALLOCATE PJBUDSUM_Csr
 
 --Update Future Rollup
 SELECT @PJBUDROL_amount_bf = amount_bf, @PJBUDROL_ProjCury_amount_bf = ProjCury_amount_bf,
        @PJBUDROL_total_amount = total_amount, @PJBUDROL_ProjCury_total_amt = ProjCury_total_amt,
        @PJBUDROL_units_bf = units_bf,
        @PJBUDROL_total_units = total_units
   FROM PJBUDROL
  WHERE fsyear_num = @fsyear_num
    AND project = @project
    AND Acct = @acct
    AND planNbr = @planNbr
 IF @@ERROR <> 0
    BEGIN
       SET @ERRORNBR = 5000
       GOTO ABORT
    END

 SET @tamt = ROUND(@PJBUDROL_amount_bf + @PJBUDROL_total_amount, @BasePrecision)
 SET @ProjCurytamt = ROUND(@PJBUDROL_ProjCury_amount_bf + @PJBUDROL_ProjCury_total_amt, @ProjCuryPrecision)
 SET @tunt = ROUND(@PJBUDROL_units_bf + @PJBUDROL_total_units, @UnitPrecision)

 DECLARE PJBUDROL_Csr INSENSITIVE CURSOR FOR
  SELECT fsyear_num, total_amount, ProjCury_total_amt, total_units
    FROM PJBUDROL
   WHERE fsyear_num > @fsyear_num
     AND project = @project
     AND Acct = @acct
     AND planNbr = @planNbr
   ORDER BY PJBUDROL.fsyear_num, PJBUDROL.project, PJBUDROL.acct, PJBUDROL.planNbr

    OPEN PJBUDROL_Csr
   FETCH PJBUDROL_Csr INTO @Next_fsyear, @PJBUDROL_total_amount, @PJBUDROL_ProjCury_total_amt, @PJBUDROL_total_units
   IF @@ERROR <> 0
   BEGIN
      CLOSE PJBUDROL_Csr
      DEALLOCATE PJBUDROL_Csr
      SET @ERRORNBR = 5000
      GOTO ABORT
   END

 WHILE @@FETCH_STATUS = 0
 BEGIN
    --PRINT 'Balance Forward Amount = '  + CAST(@tamt AS VARCHAR(25)) + ' For Fiscal Year ' + @Next_fsyear   
    UPDATE PJBUDROL
       SET amount_bf = @tamt, ProjCury_amount_bf = @ProjCurytamt, units_bf = @tunt, lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
     WHERE fsyear_num = @Next_fsyear
       AND project = @project
       AND Acct = @acct
       AND planNbr = @planNbr
    IF @@ERROR <> 0
    BEGIN
       CLOSE PJBUDROL_Csr
       DEALLOCATE PJBUDROL_Csr
       SET @ERRORNBR = 5000
       GOTO ABORT
    END

    SET @tamt = ROUND(@tamt + @PJBUDROL_total_amount, @BasePrecision)
    SET @ProjCurytamt = ROUND(@ProjCurytamt + @PJBUDROL_ProjCury_total_amt, @ProjCuryPrecision)
    SET @tamt = ROUND(@tunt + @PJBUDROL_total_units, @UnitPrecision)

    -- get next record, if any, and loop.
    FETCH PJBUDROL_Csr INTO @Next_fsyear, @PJBUDROL_total_amount, @PJBUDROL_ProjCury_total_amt, @PJBUDROL_total_units
    IF @@ERROR <> 0
    BEGIN
       CLOSE PJBUDROL_Csr
       DEALLOCATE PJBUDROL_Csr
       SET @ERRORNBR = 5000
       GOTO ABORT
    END
 END

 CLOSE PJBUDROL_Csr
 DEALLOCATE PJBUDROL_Csr 

 SELECT @PPResult = 0
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
    2000 - PJBUDSUM
    3000 - PJBUDROL
    4000 - PJBUDSUM Future Summary
    5000 - PJBUDROL Future Summary 
 **/
 SELECT @PPResult = @ERRORNBR

 FINISH:

