 
 CREATE PROCEDURE pp_TimesheetUPDATE_PJACTRolACTSum @Acct VARCHAR(16), @FiscalNo VARCHAR(6), @Project VARCHAR(16), @Task VARCHAR(32),
                                                    @Amount FLOAT, @Units FLOAT, @ProgID VARCHAR(8), @SolUser Varchar(10),
                                                    @ProjCuryAmount FLOAT, @ProjCuryPrecision As INT, @BasePrecision INT,
                                                    @PPResult INT OUTPUT, @PPErrTable VARCHAR(20) OUTPUT                                
AS
 
 DECLARE @ERRORNBR INT
 DECLARE @FsPeriod_num VARCHAR(2)
 SET @FsPeriod_num = SUBSTRING(@FiscalNo,5,2)
 DECLARE @fsyear_num VARCHAR(4)
 SET @fsyear_num = LEFT(@FiscalNo,4)
                                       
  IF (SELECT project FROM PJACTROL WHERE fsyear_num = @fsyear_num AND project = @Project AND acct = @Acct) is null
     BEGIN
        INSERT PJACTROL (acct, amount_01, amount_02, amount_03, amount_04, 
                         amount_05, amount_06, amount_07, amount_08, amount_09, 
                         amount_10, amount_11, amount_12, amount_13, amount_14, 
                         amount_15, amount_bf, crtd_datetime, crtd_prog, crtd_user, 
                         data1, fsyear_num, lupd_datetime, lupd_prog, lupd_user,
                         ProjCury_amount_01, ProjCury_amount_02, ProjCury_amount_03, ProjCury_amount_04, ProjCury_amount_05, 
                         ProjCury_amount_06, ProjCury_amount_07, ProjCury_amount_08, ProjCury_amount_09, ProjCury_amount_10, 
                         ProjCury_amount_11, ProjCury_amount_12, ProjCury_amount_13, ProjCury_amount_14, ProjCury_amount_15, 
                         ProjCury_amount_bf, 
                         project, units_01, units_02, units_03, units_04, 
                         units_05, units_06, units_07, units_08, units_09, 
                         units_10, units_11, units_12, units_13, units_14, 
                         units_15, units_bf)
        VALUES (@Acct, 
                CASE @FsPeriod_num WHEN '01' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '02' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '03' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '04' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '05' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '06' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '07' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '08' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '09' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '10' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '11' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '12' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '13' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '14' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '15' THEN @Amount ELSE 0 END, 
                0, GETDATE(), @ProgID, @SolUser, 
                '', @fsyear_num, GETDATE(), @ProgID, @SolUser,
                CASE @FsPeriod_num WHEN '01' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '02' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '03' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '04' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '05' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '06' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '07' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '08' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '09' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '10' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '11' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '12' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '13' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '14' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '15' THEN @ProjCuryAmount ELSE 0 END,                  
                0, @Project, 
                CASE @FsPeriod_num WHEN '01' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '02' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '03' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '04' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '05' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '06' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '07' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '08' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '09' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '10' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '11' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '12' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '13' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '14' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '15' THEN @Units ELSE 0 END, 0)
        IF @@ERROR <> 0
           BEGIN
             SET @ERRORNBR = 1000
             SET @PPErrTable = 'PJACTROL'
             GOTO ABORT
           END        
     END
  ELSE
     BEGIN
        UPDATE PJACTROL
           SET amount_01 = CASE @FsPeriod_num WHEN '01' THEN ROUND(amount_01 + @Amount,@BasePrecision) ELSE amount_01 END, 
               amount_02 = CASE @FsPeriod_num WHEN '02' THEN ROUND(amount_02 + @Amount,@BasePrecision) ELSE amount_02 END, 
               amount_03 = CASE @FsPeriod_num WHEN '03' THEN ROUND(amount_03 + @Amount,@BasePrecision) ELSE amount_03 END, 
               amount_04 = CASE @FsPeriod_num WHEN '04' THEN ROUND(amount_04 + @Amount,@BasePrecision) ELSE amount_04 END, 
               amount_05 = CASE @FsPeriod_num WHEN '05' THEN ROUND(amount_05 + @Amount,@BasePrecision) ELSE amount_05 END, 
               amount_06 = CASE @FsPeriod_num WHEN '06' THEN ROUND(amount_06 + @Amount,@BasePrecision) ELSE amount_06 END, 
               amount_07 = CASE @FsPeriod_num WHEN '07' THEN ROUND(amount_07 + @Amount,@BasePrecision) ELSE amount_07 END, 
               amount_08 = CASE @FsPeriod_num WHEN '08' THEN ROUND(amount_08 + @Amount,@BasePrecision) ELSE amount_08 END, 
               amount_09 = CASE @FsPeriod_num WHEN '09' THEN ROUND(amount_09 + @Amount,@BasePrecision) ELSE amount_09 END, 
               amount_10 = CASE @FsPeriod_num WHEN '10' THEN ROUND(amount_10 + @Amount,@BasePrecision) ELSE amount_10 END, 
               amount_11 = CASE @FsPeriod_num WHEN '11' THEN ROUND(amount_11 + @Amount,@BasePrecision) ELSE amount_11 END, 
               amount_12 = CASE @FsPeriod_num WHEN '12' THEN ROUND(amount_12 + @Amount,@BasePrecision) ELSE amount_12 END, 
               amount_13 = CASE @FsPeriod_num WHEN '13' THEN ROUND(amount_13 + @Amount,@BasePrecision) ELSE amount_13 END, 
               amount_14 = CASE @FsPeriod_num WHEN '14' THEN ROUND(amount_14 + @Amount,@BasePrecision) ELSE amount_14 END, 
               amount_15 = CASE @FsPeriod_num WHEN '15' THEN ROUND(amount_15 + @Amount,@BasePrecision) ELSE amount_15 END,
               ProjCury_amount_01 = CASE @FsPeriod_num WHEN '01'
                                        THEN ROUND(ProjCury_amount_01 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_01 END, 
               ProjCury_amount_02 = CASE @FsPeriod_num WHEN '02' 
                                        THEN ROUND(ProjCury_amount_02 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_02 END, 
               ProjCury_amount_03 = CASE @FsPeriod_num WHEN '03'
                                        THEN ROUND(ProjCury_amount_03 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_03 END, 
               ProjCury_amount_04 = CASE @FsPeriod_num WHEN '04'
                                        THEN ROUND(ProjCury_amount_04 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_04 END, 
               ProjCury_amount_05 = CASE @FsPeriod_num WHEN '05'
                                        THEN ROUND(ProjCury_amount_05 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_05 END, 
               ProjCury_amount_06 = CASE @FsPeriod_num WHEN '06'
                                        THEN ROUND(ProjCury_amount_06 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_06 END, 
               ProjCury_amount_07 = CASE @FsPeriod_num WHEN '07'
                                        THEN ROUND(ProjCury_amount_07 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_07 END, 
               ProjCury_amount_08 = CASE @FsPeriod_num WHEN '08'
                                        THEN ROUND(ProjCury_amount_08 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_08 END, 
               ProjCury_amount_09 = CASE @FsPeriod_num WHEN '09'
                                        THEN ROUND(ProjCury_amount_09 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_09 END, 
               ProjCury_amount_10 = CASE @FsPeriod_num WHEN '10'
                                        THEN ROUND(ProjCury_amount_10 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_10 END, 
               ProjCury_amount_11 = CASE @FsPeriod_num WHEN '11'
                                        THEN ROUND(ProjCury_amount_11 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_11 END, 
               ProjCury_amount_12 = CASE @FsPeriod_num WHEN '12'
                                        THEN ROUND(ProjCury_amount_12 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_12 END, 
               ProjCury_amount_13 = CASE @FsPeriod_num WHEN '13'
                                        THEN ROUND(ProjCury_amount_13 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_13 END, 
               ProjCury_amount_14 = CASE @FsPeriod_num WHEN '14'
                                        THEN ROUND(ProjCury_amount_14 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_14 END, 
               ProjCury_amount_15 = CASE @FsPeriod_num WHEN '15'
                                        THEN ROUND(ProjCury_amount_15 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_15 END,
               units_01 = CASE @FsPeriod_num WHEN '01' THEN ROUND(units_01 + @Units,2) ELSE units_01 END, 
               units_02 = CASE @FsPeriod_num WHEN '02' THEN ROUND(units_02 + @Units,2) ELSE units_02 END, 
               units_03 = CASE @FsPeriod_num WHEN '03' THEN ROUND(units_03 + @Units,2) ELSE units_03 END, 
               units_04 = CASE @FsPeriod_num WHEN '04' THEN ROUND(units_04 + @Units,2) ELSE units_04 END, 
               units_05 = CASE @FsPeriod_num WHEN '05' THEN ROUND(units_05 + @Units,2) ELSE units_05 END, 
               units_06 = CASE @FsPeriod_num WHEN '06' THEN ROUND(units_06 + @Units,2) ELSE units_06 END, 
               units_07 = CASE @FsPeriod_num WHEN '07' THEN ROUND(units_07 + @Units,2) ELSE units_07 END, 
               units_08 = CASE @FsPeriod_num WHEN '08' THEN ROUND(units_08 + @Units,2) ELSE units_08 END, 
               units_09 = CASE @FsPeriod_num WHEN '09' THEN ROUND(units_09 + @Units,2) ELSE units_09 END, 
               units_10 = CASE @FsPeriod_num WHEN '10' THEN ROUND(units_10 + @Units,2) ELSE units_10 END, 
               units_11 = CASE @FsPeriod_num WHEN '11' THEN ROUND(units_11 + @Units,2) ELSE units_11 END, 
               units_12 = CASE @FsPeriod_num WHEN '12' THEN ROUND(units_12 + @Units,2) ELSE units_12 END, 
               units_13 = CASE @FsPeriod_num WHEN '13' THEN ROUND(units_13 + @Units,2) ELSE units_13 END, 
               units_14 = CASE @FsPeriod_num WHEN '14' THEN ROUND(units_14 + @Units,2) ELSE units_14 END, 
               units_15 = CASE @FsPeriod_num WHEN '15' THEN ROUND(units_15 + @Units,2) ELSE units_15 END,
               lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser
         WHERE fsyear_num = @fsyear_num 
           AND project = @Project 
           AND acct = @Acct  
        IF @@ERROR <> 0
           BEGIN
             SET @ERRORNBR = 1100
             SET @PPErrTable = 'PJACTROL'
             GOTO ABORT
           END 
     END

  IF (SELECT project FROM PJACTSUM WHERE fsyear_num = @fsyear_num AND project = @Project AND pjt_entity = @Task AND acct = @Acct) is null
     BEGIN
        INSERT PJACTSUM (acct, amount_01, amount_02, amount_03, amount_04, 
                         amount_05, amount_06, amount_07, amount_08, amount_09, 
                         amount_10, amount_11, amount_12, amount_13, amount_14, 
                         amount_15, amount_bf, crtd_datetime, crtd_prog, crtd_user, 
                         data1, fsyear_num, lupd_datetime, lupd_prog, lupd_user, 
                         pjt_entity, 
                         ProjCury_amount_01, ProjCury_amount_02, ProjCury_amount_03, ProjCury_amount_04, 
                         ProjCury_amount_05, ProjCury_amount_06, ProjCury_amount_07, ProjCury_amount_08, ProjCury_amount_09, 
                         ProjCury_amount_10, ProjCury_amount_11, ProjCury_amount_12, ProjCury_amount_13, ProjCury_amount_14, 
                         ProjCury_amount_15, ProjCury_amount_bf,
                         project, units_01, units_02, units_03, units_04, 
                         units_05, units_06, units_07, units_08, units_09, 
                         units_10, units_11, units_12, units_13, units_14, 
                         units_15, units_bf)
        VALUES (@Acct, 
                CASE @FsPeriod_num WHEN '01' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '02' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '03' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '04' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '05' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '06' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '07' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '08' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '09' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '10' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '11' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '12' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '13' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '14' THEN @Amount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '15' THEN @Amount ELSE 0 END, 
                0, GETDATE(), @ProgID, @SolUser, 
                '', @fsyear_num, GETDATE(), @ProgID, @SolUser, 
                @Task, 
                CASE @FsPeriod_num WHEN '01' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '02' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '03' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '04' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '05' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '06' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '07' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '08' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '09' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '10' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '11' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '12' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '13' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '14' THEN @ProjCuryAmount ELSE 0 END, 
                CASE @FsPeriod_num WHEN '15' THEN @ProjCuryAmount ELSE 0 END, 
                0, @Project, 
                CASE @FsPeriod_num WHEN '01' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '02' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '03' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '04' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '05' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '06' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '07' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '08' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '09' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '10' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '11' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '12' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '13' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '14' THEN @Units ELSE 0 END, 
                CASE @FsPeriod_num WHEN '15' THEN @Units ELSE 0 END, 0)
        IF @@ERROR <> 0
           BEGIN
             SET @ERRORNBR = 1200
             SET @PPErrTable = 'PJACTSUM'
             GOTO ABORT
           END        
     END 
  ELSE
     BEGIN
        UPDATE PJACTSUM
           SET amount_01 = CASE @FsPeriod_num WHEN '01' THEN ROUND(amount_01 + @Amount,@BasePrecision) ELSE amount_01 END, 
               amount_02 = CASE @FsPeriod_num WHEN '02' THEN ROUND(amount_02 + @Amount,@BasePrecision) ELSE amount_02 END, 
               amount_03 = CASE @FsPeriod_num WHEN '03' THEN ROUND(amount_03 + @Amount,@BasePrecision) ELSE amount_03 END, 
               amount_04 = CASE @FsPeriod_num WHEN '04' THEN ROUND(amount_04 + @Amount,@BasePrecision) ELSE amount_04 END, 
               amount_05 = CASE @FsPeriod_num WHEN '05' THEN ROUND(amount_05 + @Amount,@BasePrecision) ELSE amount_05 END, 
               amount_06 = CASE @FsPeriod_num WHEN '06' THEN ROUND(amount_06 + @Amount,@BasePrecision) ELSE amount_06 END, 
               amount_07 = CASE @FsPeriod_num WHEN '07' THEN ROUND(amount_07 + @Amount,@BasePrecision) ELSE amount_07 END, 
               amount_08 = CASE @FsPeriod_num WHEN '08' THEN ROUND(amount_08 + @Amount,@BasePrecision) ELSE amount_08 END, 
               amount_09 = CASE @FsPeriod_num WHEN '09' THEN ROUND(amount_09 + @Amount,@BasePrecision) ELSE amount_09 END, 
               amount_10 = CASE @FsPeriod_num WHEN '10' THEN ROUND(amount_10 + @Amount,@BasePrecision) ELSE amount_10 END, 
               amount_11 = CASE @FsPeriod_num WHEN '11' THEN ROUND(amount_11 + @Amount,@BasePrecision) ELSE amount_11 END, 
               amount_12 = CASE @FsPeriod_num WHEN '12' THEN ROUND(amount_12 + @Amount,@BasePrecision) ELSE amount_12 END, 
               amount_13 = CASE @FsPeriod_num WHEN '13' THEN ROUND(amount_13 + @Amount,@BasePrecision) ELSE amount_13 END, 
               amount_14 = CASE @FsPeriod_num WHEN '14' THEN ROUND(amount_14 + @Amount,@BasePrecision) ELSE amount_14 END, 
               amount_15 = CASE @FsPeriod_num WHEN '15' THEN ROUND(amount_15 + @Amount,@BasePrecision) ELSE amount_15 END,
               ProjCury_amount_01 = CASE @FsPeriod_num WHEN '01'
                                        THEN ROUND(ProjCury_amount_01 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_01 END, 
               ProjCury_amount_02 = CASE @FsPeriod_num WHEN '02' 
                                        THEN ROUND(ProjCury_amount_02 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_02 END, 
               ProjCury_amount_03 = CASE @FsPeriod_num WHEN '03'
                                        THEN ROUND(ProjCury_amount_03 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_03 END, 
               ProjCury_amount_04 = CASE @FsPeriod_num WHEN '04'
                                        THEN ROUND(ProjCury_amount_04 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_04 END, 
               ProjCury_amount_05 = CASE @FsPeriod_num WHEN '05'
                                        THEN ROUND(ProjCury_amount_05 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_05 END, 
               ProjCury_amount_06 = CASE @FsPeriod_num WHEN '06'
                                        THEN ROUND(ProjCury_amount_06 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_06 END, 
               ProjCury_amount_07 = CASE @FsPeriod_num WHEN '07'
                                        THEN ROUND(ProjCury_amount_07 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_07 END, 
               ProjCury_amount_08 = CASE @FsPeriod_num WHEN '08'
                                        THEN ROUND(ProjCury_amount_08 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_08 END, 
               ProjCury_amount_09 = CASE @FsPeriod_num WHEN '09'
                                        THEN ROUND(ProjCury_amount_09 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_09 END, 
               ProjCury_amount_10 = CASE @FsPeriod_num WHEN '10'
                                        THEN ROUND(ProjCury_amount_10 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_10 END, 
               ProjCury_amount_11 = CASE @FsPeriod_num WHEN '11'
                                        THEN ROUND(ProjCury_amount_11 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_11 END, 
               ProjCury_amount_12 = CASE @FsPeriod_num WHEN '12'
                                        THEN ROUND(ProjCury_amount_12 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_12 END, 
               ProjCury_amount_13 = CASE @FsPeriod_num WHEN '13'
                                        THEN ROUND(ProjCury_amount_13 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_13 END, 
               ProjCury_amount_14 = CASE @FsPeriod_num WHEN '14'
                                        THEN ROUND(ProjCury_amount_14 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_14 END, 
               ProjCury_amount_15 = CASE @FsPeriod_num WHEN '15'
                                        THEN ROUND(ProjCury_amount_15 + @ProjCuryAmount,@ProjCuryPrecision) ELSE ProjCury_amount_15 END,               
               units_01 = CASE @FsPeriod_num WHEN '01' THEN ROUND(units_01 + @Units,2) ELSE units_01 END, 
               units_02 = CASE @FsPeriod_num WHEN '02' THEN ROUND(units_02 + @Units,2) ELSE units_02 END, 
               units_03 = CASE @FsPeriod_num WHEN '03' THEN ROUND(units_03 + @Units,2) ELSE units_03 END, 
               units_04 = CASE @FsPeriod_num WHEN '04' THEN ROUND(units_04 + @Units,2) ELSE units_04 END, 
               units_05 = CASE @FsPeriod_num WHEN '05' THEN ROUND(units_05 + @Units,2) ELSE units_05 END, 
               units_06 = CASE @FsPeriod_num WHEN '06' THEN ROUND(units_06 + @Units,2) ELSE units_06 END, 
               units_07 = CASE @FsPeriod_num WHEN '07' THEN ROUND(units_07 + @Units,2) ELSE units_07 END, 
               units_08 = CASE @FsPeriod_num WHEN '08' THEN ROUND(units_08 + @Units,2) ELSE units_08 END, 
               units_09 = CASE @FsPeriod_num WHEN '09' THEN ROUND(units_09 + @Units,2) ELSE units_09 END, 
               units_10 = CASE @FsPeriod_num WHEN '10' THEN ROUND(units_10 + @Units,2) ELSE units_10 END, 
               units_11 = CASE @FsPeriod_num WHEN '11' THEN ROUND(units_11 + @Units,2) ELSE units_11 END, 
               units_12 = CASE @FsPeriod_num WHEN '12' THEN ROUND(units_12 + @Units,2) ELSE units_12 END, 
               units_13 = CASE @FsPeriod_num WHEN '13' THEN ROUND(units_13 + @Units,2) ELSE units_13 END, 
               units_14 = CASE @FsPeriod_num WHEN '14' THEN ROUND(units_14 + @Units,2) ELSE units_14 END, 
               units_15 = CASE @FsPeriod_num WHEN '15' THEN ROUND(units_15 + @Units,2) ELSE units_15 END,
               lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @SolUser
         WHERE fsyear_num = @fsyear_num 
           AND project = @Project
           AND pjt_entity = @Task 
           AND acct = @Acct  
        IF @@ERROR <> 0
           BEGIN
             SET @ERRORNBR = 1300
             SET @PPErrTable = 'PJACTSUM'
             GOTO ABORT
           END 
     END 


     
 SELECT @PPResult = 0
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
    1000 - PJACTROL Insert
    1100 - PJACTROL Update
    1200 - PJACTSUM Insert
    1300 - PJACTSUM Update
 **/
 SELECT @PPResult = @ERRORNBR

 FINISH:     


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_TimesheetUPDATE_PJACTRolACTSum] TO [MSDSL]
    AS [dbo];

