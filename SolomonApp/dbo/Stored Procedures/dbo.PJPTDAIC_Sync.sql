﻿
CREATE PROC [dbo].[PJPTDAIC_Sync] (
                @screen CHAR (8),
                @user CHAR (10),
                @cpnyid CHAR (10),
                @period CHAR (6),
                @project CHAR (16) = '%',
                @pjt_entity CHAR (32) = '%') AS

-- This procedure will call the PJAIC_Summary stored procedure using the passed parameters. It will use the results
-- to sync up the PJPTDAIC table.
-- This will be called after the Allocation Processor or Indirect Rate Calculator is run.

SET NOCOUNT ON

DECLARE @fsperiod_num CHAR(2)
DECLARE @today SMALLDATETIME

SET @fsperiod_num = SUBSTRING(@period, 5, 2)
SET @today = CONVERT(SMALLDATETIME, GETDATE())

-- Excecuting the PJfINDSUM() function multiple times could be a lengthy process and is unnecessary.
-- Put the results of the initial function call into a table memory variable so we can use the results as often as we need to.
DECLARE @PJAIC_summary TABLE (
    [acct] [char](16) NOT NULL,
    [amount_01] [float] NOT NULL, [amount_02] [float] NOT NULL, [amount_03] [float] NOT NULL,
    [amount_04] [float] NOT NULL, [amount_05] [float] NOT NULL, [amount_06] [float] NOT NULL,
    [amount_07] [float] NOT NULL, [amount_08] [float] NOT NULL, [amount_09] [float] NOT NULL,
    [amount_10] [float] NOT NULL, [amount_11] [float] NOT NULL, [amount_12] [float] NOT NULL,
    [amount_13] [float] NOT NULL, [amount_14] [float] NOT NULL, [amount_15] [float] NOT NULL,
    [fsyear_num] [char](4) NOT NULL,
    [pjt_entity] [char](32) NOT NULL,
    [projcury_amount_01] [float] NOT NULL, [projcury_amount_02] [float] NOT NULL, [projcury_amount_03] [float] NOT NULL,
    [projcury_amount_04] [float] NOT NULL, [projcury_amount_05] [float] NOT NULL, [projcury_amount_06] [float] NOT NULL,
    [projcury_amount_07] [float] NOT NULL, [projcury_amount_08] [float] NOT NULL, [projcury_amount_09] [float] NOT NULL,
    [projcury_amount_10] [float] NOT NULL, [projcury_amount_11] [float] NOT NULL, [projcury_amount_12] [float] NOT NULL,
    [projcury_amount_13] [float] NOT NULL, [projcury_amount_14] [float] NOT NULL, [projcury_amount_15] [float] NOT NULL,
    [projcuryid] [char] (4) NOT NULL,
    [projcurymultidiv_01] [char](1) NOT NULL, [projcurymultidiv_02] [char](1) NOT NULL, [projcurymultidiv_03] [char](1) NOT NULL,
    [projcurymultidiv_04] [char](1) NOT NULL, [projcurymultidiv_05] [char](1) NOT NULL, [projcurymultidiv_06] [char](1) NOT NULL,
    [projcurymultidiv_07] [char](1) NOT NULL, [projcurymultidiv_08] [char](1) NOT NULL, [projcurymultidiv_09] [char](1) NOT NULL,
    [projcurymultidiv_10] [char](1) NOT NULL, [projcurymultidiv_11] [char](1) NOT NULL, [projcurymultidiv_12] [char](1) NOT NULL,
    [projcurymultidiv_13] [char](1) NOT NULL, [projcurymultidiv_14] [char](1) NOT NULL, [projcurymultidiv_15] [char](1) NOT NULL,
    [projcuryrate_01] [Float] NOT NULL, [projcuryrate_02] [Float] NOT NULL, [projcuryrate_03] [Float] NOT NULL,
    [projcuryrate_04] [Float] NOT NULL, [projcuryrate_05] [Float] NOT NULL, [projcuryrate_06] [Float] NOT NULL,
    [projcuryrate_07] [Float] NOT NULL, [projcuryrate_08] [Float] NOT NULL, [projcuryrate_09] [Float] NOT NULL,
    [projcuryrate_10] [Float] NOT NULL, [projcuryrate_11] [Float] NOT NULL, [projcuryrate_12] [Float] NOT NULL,
    [projcuryrate_13] [Float] NOT NULL, [projcuryrate_14] [Float] NOT NULL, [projcuryrate_15] [Float] NOT NULL,
    [project] [char](16) NOT NULL,
    [rate_01] [float] NOT NULL, [rate_02] [float] NOT NULL, [rate_03] [float] NOT NULL,
    [rate_04] [float] NOT NULL, [rate_05] [float] NOT NULL, [rate_06] [float] NOT NULL,
    [rate_07] [float] NOT NULL, [rate_08] [float] NOT NULL, [rate_09] [float] NOT NULL,
    [rate_10] [float] NOT NULL, [rate_11] [float] NOT NULL, [rate_12] [float] NOT NULL,
    [rate_13] [float] NOT NULL, [rate_14] [float] NOT NULL, [rate_15] [float] NOT NULL)

INSERT INTO @PJAIC_summary
    EXEC PJAIC_summary @cpnyid, @period, 'P', @project, @pjt_entity
IF @@error != 0
    RETURN(@@error)

-- Sync the PTD AIC table
-- Update this period for rows that already exist
IF @fsperiod_num = '01'
    UPDATE aic
        SET aic.amount_01 = new_aic.amount_01,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_01 = new_aic.projcury_amount_01,
            aic.ProjCuryMultiDiv_01 = new_aic.projcurymultidiv_01,
            aic.ProjCuryRate_01 = new_aic.projcuryrate_01,
            aic.rate_01 = new_aic.rate_01
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '02'
    UPDATE aic
        SET aic.amount_02 = new_aic.amount_02,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_02 = new_aic.projcury_amount_02,
            aic.ProjCuryMultiDiv_02 = new_aic.projcurymultidiv_02,
            aic.ProjCuryRate_02 = new_aic.projcuryrate_02,
            aic.rate_02 = new_aic.rate_02
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '03'
    UPDATE aic
        SET aic.amount_03 = new_aic.amount_03,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_03 = new_aic.projcury_amount_03,
            aic.ProjCuryMultiDiv_03 = new_aic.projcurymultidiv_03,
            aic.ProjCuryRate_03 = new_aic.projcuryrate_03,
            aic.rate_03 = new_aic.rate_03
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '04'
    UPDATE aic
        SET aic.amount_04 = new_aic.amount_04,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_04 = new_aic.projcury_amount_04,
            aic.ProjCuryMultiDiv_04 = new_aic.projcurymultidiv_04,
            aic.ProjCuryRate_04 = new_aic.projcuryrate_04,
            aic.rate_04 = new_aic.rate_04
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '05'
    UPDATE aic
        SET aic.amount_05 = new_aic.amount_05,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_05 = new_aic.projcury_amount_05,
            aic.ProjCuryMultiDiv_05 = new_aic.projcurymultidiv_05,
            aic.ProjCuryRate_05 = new_aic.projcuryrate_05,
            aic.rate_05 = new_aic.rate_05
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '06'
    UPDATE aic
        SET aic.amount_06 = new_aic.amount_06,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_06 = new_aic.projcury_amount_06,
            aic.ProjCuryMultiDiv_06 = new_aic.projcurymultidiv_06,
            aic.ProjCuryRate_06 = new_aic.projcuryrate_06,
            aic.rate_06 = new_aic.rate_06
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '07'
    UPDATE aic
        SET aic.amount_07 = new_aic.amount_07,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_07 = new_aic.projcury_amount_07,
            aic.ProjCuryMultiDiv_07 = new_aic.projcurymultidiv_07,
            aic.ProjCuryRate_07 = new_aic.projcuryrate_07,
            aic.rate_07 = new_aic.rate_07
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '08'
    UPDATE aic
        SET aic.amount_08 = new_aic.amount_08,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_08 = new_aic.projcury_amount_08,
            aic.ProjCuryMultiDiv_08 = new_aic.projcurymultidiv_08,
            aic.ProjCuryRate_08 = new_aic.projcuryrate_08,
            aic.rate_08 = new_aic.rate_08
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '09'
    UPDATE aic
        SET aic.amount_09 = new_aic.amount_09,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_09 = new_aic.projcury_amount_09,
            aic.ProjCuryMultiDiv_09 = new_aic.projcurymultidiv_09,
            aic.ProjCuryRate_09 = new_aic.projcuryrate_09,
            aic.rate_09 = new_aic.rate_09
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '10'
    UPDATE aic
        SET aic.amount_10 = new_aic.amount_10,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_10 = new_aic.projcury_amount_10,
            aic.ProjCuryMultiDiv_10 = new_aic.projcurymultidiv_10,
            aic.ProjCuryRate_10 = new_aic.projcuryrate_10,
            aic.rate_10 = new_aic.rate_10
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '11'
    UPDATE aic
        SET aic.amount_11 = new_aic.amount_11,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_11 = new_aic.projcury_amount_11,
            aic.ProjCuryMultiDiv_11 = new_aic.projcurymultidiv_11,
            aic.ProjCuryRate_11 = new_aic.projcuryrate_11,
            aic.rate_11 = new_aic.rate_11
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '12'
    UPDATE aic
        SET aic.amount_12 = new_aic.amount_12,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_12 = new_aic.projcury_amount_12,
            aic.ProjCuryMultiDiv_12 = new_aic.projcurymultidiv_12,
            aic.ProjCuryRate_12 = new_aic.projcuryrate_12,
            aic.rate_12 = new_aic.rate_12
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '13'
    UPDATE aic
        SET aic.amount_13 = new_aic.amount_13,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_13 = new_aic.projcury_amount_13,
            aic.ProjCuryMultiDiv_13 = new_aic.projcurymultidiv_13,
            aic.ProjCuryRate_13 = new_aic.projcuryrate_13,
            aic.rate_13 = new_aic.rate_13
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '14'
    UPDATE aic
        SET aic.amount_14 = new_aic.amount_14,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_14 = new_aic.projcury_amount_14,
            aic.ProjCuryMultiDiv_14 = new_aic.projcurymultidiv_14,
            aic.ProjCuryRate_14 = new_aic.projcuryrate_14,
            aic.rate_14 = new_aic.rate_14
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
ELSE IF @fsperiod_num = '15'
    UPDATE aic
        SET aic.amount_15 = new_aic.amount_15,
            aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user,
            aic.ProjCury_amount_15 = new_aic.projcury_amount_15,
            aic.ProjCuryMultiDiv_15 = new_aic.projcurymultidiv_15,
            aic.ProjCuryRate_15 = new_aic.projcuryrate_15,
            aic.rate_15 = new_aic.rate_15
        FROM @PJAIC_summary as new_aic
        JOIN PJPTDAIC AS aic
            ON aic.fsyear_num = new_aic.fsyear_num
                and aic.project = new_aic.project
                and aic.pjt_entity = new_aic.pjt_entity
                and aic.acct = new_aic.acct
IF @@error != 0
    RETURN(@@error)

-- Insert rows that do NOT exist
INSERT INTO PJPTDAIC (
    [acct],
    [amount_01], [amount_02], [amount_03], [amount_04], [amount_05],
    [amount_06], [amount_07], [amount_08], [amount_09], [amount_10],
    [amount_11], [amount_12], [amount_13], [amount_14], [amount_15],
    [amount_bf],
    [crtd_datetime], [crtd_prog], [crtd_user],
    [fsyear_num],
    [lupd_datetime], [lupd_prog], [lupd_user],
    [pjt_entity],
    [ProjCury_amount_01], [ProjCury_amount_02], [ProjCury_amount_03], [ProjCury_amount_04], [ProjCury_amount_05],
    [ProjCury_amount_06], [ProjCury_amount_07], [ProjCury_amount_08], [ProjCury_amount_09], [ProjCury_amount_10],
    [ProjCury_amount_11], [ProjCury_amount_12], [ProjCury_amount_13], [ProjCury_amount_14], [ProjCury_amount_15],
    [ProjCury_amount_bf],
    [ProjCuryId],
    [ProjCuryMultiDiv_01], [ProjCuryMultiDiv_02], [ProjCuryMultiDiv_03], [ProjCuryMultiDiv_04], [ProjCuryMultiDiv_05],
    [ProjCuryMultiDiv_06], [ProjCuryMultiDiv_07], [ProjCuryMultiDiv_08], [ProjCuryMultiDiv_09], [ProjCuryMultiDiv_10],
    [ProjCuryMultiDiv_11], [ProjCuryMultiDiv_12], [ProjCuryMultiDiv_13], [ProjCuryMultiDiv_14], [ProjCuryMultiDiv_15],
    [ProjCuryRate_01], [ProjCuryRate_02], [ProjCuryRate_03], [ProjCuryRate_04], [ProjCuryRate_05],
    [ProjCuryRate_06], [ProjCuryRate_07], [ProjCuryRate_08], [ProjCuryRate_09], [ProjCuryRate_10],
    [ProjCuryRate_11], [ProjCuryRate_12], [ProjCuryRate_13], [ProjCuryRate_14], [ProjCuryRate_15],
    [project],
    [rate_01], [rate_02], [rate_03], [rate_04], [rate_05],
    [rate_06], [rate_07], [rate_08], [rate_09], [rate_10],
    [rate_11], [rate_12], [rate_13], [rate_14], [rate_15])
    SELECT new_aic.acct,
            new_aic.amount_01, new_aic.amount_02, new_aic.amount_03, new_aic.amount_04, new_aic.amount_05,
            new_aic.amount_06, new_aic.amount_07, new_aic.amount_08, new_aic.amount_09, new_aic.amount_10,
            new_aic.amount_11, new_aic.amount_12, new_aic.amount_13, new_aic.amount_14, new_aic.amount_15,
            0,
            @today, @screen, @user,
            new_aic.fsyear_num,
            @today, @screen, @user,
            new_aic.pjt_entity,
            new_aic.projcury_amount_01, new_aic.projcury_amount_02, new_aic.projcury_amount_03, new_aic.projcury_amount_04, new_aic.projcury_amount_05,
            new_aic.projcury_amount_06, new_aic.projcury_amount_07, new_aic.projcury_amount_08, new_aic.projcury_amount_09, new_aic.projcury_amount_10,
            new_aic.projcury_amount_11, new_aic.projcury_amount_12, new_aic.projcury_amount_13, new_aic.projcury_amount_14, new_aic.projcury_amount_15,
            0,
            new_aic.projcuryid,
            new_aic.projcurymultidiv_01, new_aic.projcurymultidiv_02, new_aic.projcurymultidiv_03, new_aic.projcurymultidiv_04, new_aic.projcurymultidiv_05,
            new_aic.projcurymultidiv_06, new_aic.projcurymultidiv_07, new_aic.projcurymultidiv_08, new_aic.projcurymultidiv_09, new_aic.projcurymultidiv_10,
            new_aic.projcurymultidiv_11, new_aic.projcurymultidiv_12, new_aic.projcurymultidiv_13, new_aic.projcurymultidiv_14, new_aic.projcurymultidiv_15,
            new_aic.projcuryrate_01, new_aic.projcuryrate_02, new_aic.projcuryrate_03, new_aic.projcuryrate_04, new_aic.projcuryrate_05,
            new_aic.projcuryrate_06, new_aic.projcuryrate_07, new_aic.projcuryrate_08, new_aic.projcuryrate_09, new_aic.projcuryrate_10,
            new_aic.projcuryrate_11, new_aic.projcuryrate_12, new_aic.projcuryrate_13, new_aic.projcuryrate_14, new_aic.projcuryrate_15,
            new_aic.project,
            new_aic.rate_01, new_aic.rate_02, new_aic.rate_03, new_aic.rate_04, new_aic.rate_05,
            new_aic.rate_06, new_aic.rate_07, new_aic.rate_08, new_aic.rate_09, new_aic.rate_10,
            new_aic.rate_11, new_aic.rate_12, new_aic.rate_13, new_aic.rate_14, new_aic.rate_15
        FROM @PJAIC_summary new_aic
        WHERE (new_aic.amount_01 <> 0 OR new_aic.amount_02 <> 0 OR new_aic.amount_03 <> 0 OR new_aic.amount_04 <> 0 OR new_aic.amount_05 <> 0
                OR new_aic.amount_06 <> 0 OR new_aic.amount_07 <> 0 OR new_aic.amount_08 <> 0 OR new_aic.amount_09 <> 0 OR new_aic.amount_10 <> 0
                OR new_aic.amount_11 <> 0 OR new_aic.amount_12 <> 0 OR new_aic.amount_13 <> 0 OR new_aic.amount_14 <> 0 OR new_aic.amount_15 <> 0)
         AND NOT EXISTS (SELECT TOP 1 *
                            FROM PJPTDAIC aic WITH (NOLOCK)
                            WHERE aic.fsyear_num = new_aic.fsyear_num
                                and aic.project = new_aic.project
                                and aic.pjt_entity = new_aic.pjt_entity
                                and aic.acct = new_aic.acct)
RETURN(@@error)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDAIC_Sync] TO [MSDSL]
    AS [dbo];

