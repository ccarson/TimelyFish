
CREATE PROC [dbo].[PJYTDAIC_BalanceForward] (
                @screen CHAR (8),
                @user CHAR (10),
                @period CHAR (6)) AS

-- This stored proc will set balance forward amount field for the fiscal year following the period passed.
-- It will update the balance forward fields if the record exists
-- It will create new records with the balance forward field populated if the record does not exist

SET NOCOUNT ON

DECLARE @nbrPeriods AS SMALLINT
DECLARE @project AS CHAR(16)
DECLARE @pjt_entity AS CHAR(32)
DECLARE @acct AS CHAR(16)
DECLARE @amount_bf AS FLOAT
DECLARE @ProjCury_amount_bf AS FLOAT
DECLARE @ProjCuryID CHAR(4)
DECLARE @periodNbr AS SMALLINT
DECLARE @newPeriod AS CHAR(6)
DECLARE @error INTEGER
DECLARE @today SMALLDATETIME

SET @error = 0

-- One assumption is that the period passed is the final period of the year.
-- Check this by looking for the number of periods configured in GL
SELECT @nbrPeriods = NbrPer FROM GLSetup WITH (NOLOCK)
IF @nbrPeriods <> CAST(RIGHT(@period, 2) AS SMALLINT)
    RETURN(@error)

SET @today = CONVERT(SMALLDATETIME, GETDATE())    -- timestamp for created date and last update date

-- Another assumption is that the Indirect Rate Calculator and Allocation Processor have been run for period passed.
-- We have no way to confirm this in this proc.
-- So if these have not been run, the balance forward amounts will simply be the balance forward amount from the previous fiscal year.
-- The balance forward amount from the previous year will be zero if the project started this year.

-- Need records in the new period for each project, task, and account category that exists for the current period.
-- However the balance forward amount for each new period record needs to come from the last period record.
-- The new balance forward is the previous balance forward plus all of the period amounts.

-- So we use a cursor to loop through the final period records, then create each of the new period records.

DECLARE bf_Cursor CURSOR LOCAL FAST_FORWARD
    FOR SELECT PJYTDAIC.project,
            pjt_entity,
            acct,
            amount_bf = amount_bf
                        + amount_01 + amount_02 + amount_03 + amount_04 + amount_05
                        + amount_06 + amount_07 + amount_08 + amount_09 + amount_10
                        + amount_11 + amount_12 + amount_13 + amount_14 + amount_15,
            ProjCury_amount_bf = ProjCury_amount_bf
                                 + ProjCury_amount_01 + ProjCury_amount_02 + ProjCury_amount_03 + ProjCury_amount_04 + ProjCury_amount_05
                                 + ProjCury_amount_06 + ProjCury_amount_07 + ProjCury_amount_08 + ProjCury_amount_09 + ProjCury_amount_10
                                 + ProjCury_amount_11 + ProjCury_amount_12 + ProjCury_amount_13 + ProjCury_amount_14 + ProjCury_amount_15,
            PJYTDAIC.ProjCuryId
        FROM PJYTDAIC WITH (NOLOCK)
        INNER JOIN PJPROJ WITH (NOLOCK)
            ON PJPROJ.project = PJYTDAIC.project
        WHERE period = @period

-- create a record for each period of the year
SET @periodNbr = 1
WHILE @periodNbr <= @nbrPeriods
BEGIN
    -- Add to year in @period and tack on the @periodNbr (as string with a leading zero if necessary)
    SET @newPeriod = CAST(CAST(LEFT(@period, 4) AS SMALLINT) + 1 AS CHAR(4)) + RIGHT('00' + LTRIM(RTRIM(CAST(@periodNbr AS CHAR (2)))), 2)

    -- Now loop through the final period records
    OPEN bf_Cursor

    FETCH NEXT FROM bf_Cursor
        INTO @project, @pjt_entity, @acct, @amount_bf, @ProjCury_amount_bf, @ProjCuryID
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- if next years record already exists, update it
        UPDATE aic
            SET aic.amount_bf = @amount_bf, aic.ProjCury_amount_bf = @ProjCury_amount_bf,
                aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user
        FROM PJYTDAIC AS aic
        WHERE aic.period = @newPeriod
            and aic.project = @project
            and aic.pjt_entity = @pjt_entity
            and aic.acct = @acct
            and (aic.amount_bf <> @amount_bf or aic.ProjCury_amount_bf <> @ProjCury_amount_bf)
        
        SET @error = @@ERROR
        IF @error <> 0
            BREAK

        -- if we have a balnace forward amount and next years record does not exist, create it
        IF @amount_bf <> 0 or @ProjCury_amount_bf <> 0
            INSERT INTO PJYTDAIC (
                [acct],
                [amount_01], [amount_02], [amount_03], [amount_04], [amount_05],
                [amount_06], [amount_07], [amount_08], [amount_09], [amount_10],
                [amount_11], [amount_12], [amount_13], [amount_14], [amount_15],
                [amount_bf],
                [crtd_datetime], [crtd_prog], [crtd_user], [lupd_datetime], [lupd_prog], [lupd_user],
                [period], [pjt_entity], 
                [ProjCury_amount_01], [ProjCury_amount_02], [ProjCury_amount_03], [ProjCury_amount_04], [ProjCury_amount_05],
                [ProjCury_amount_06], [ProjCury_amount_07], [ProjCury_amount_08], [ProjCury_amount_09], [ProjCury_amount_10],
                [ProjCury_amount_11], [ProjCury_amount_12], [ProjCury_amount_13], [ProjCury_amount_14], [ProjCury_amount_15],
                [ProjCury_amount_bf], [ProjCuryId],
                [ProjCuryMultiDiv_01], [ProjCuryMultiDiv_02], [ProjCuryMultiDiv_03], [ProjCuryMultiDiv_04], [ProjCuryMultiDiv_05],
                [ProjCuryMultiDiv_06], [ProjCuryMultiDiv_07], [ProjCuryMultiDiv_08], [ProjCuryMultiDiv_09], [ProjCuryMultiDiv_10],
                [ProjCuryMultiDiv_11], [ProjCuryMultiDiv_12], [ProjCuryMultiDiv_13], [ProjCuryMultiDiv_14], [ProjCuryMultiDiv_15],
                [ProjCuryRate_01], [ProjCuryRate_02], [ProjCuryRate_03], [ProjCuryRate_04], [ProjCuryRate_05],
                [ProjCuryRate_06], [ProjCuryRate_07], [ProjCuryRate_08], [ProjCuryRate_09], [ProjCuryRate_10],
                [ProjCuryRate_11], [ProjCuryRate_12], [ProjCuryRate_13], [ProjCuryRate_14], [ProjCuryRate_15],
                [project], [rate])
                SELECT @acct,
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    @amount_bf,
                    @today, @screen, @user, @today, @screen, @user,
                    @newPeriod, @pjt_entity, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    @ProjCury_amount_bf, @ProjCuryID,
                    space(0), space(0), space(0), space(0), space(0),
                    space(0), space(0), space(0), space(0), space(0),
                    space(0), space(0), space(0), space(0), space(0),
                    0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0,
                    @project, 0
                WHERE NOT EXISTS (SELECT TOP 1 *
                                  FROM PJYTDAIC aic with (nolock)
                                  WHERE aic.period = @newPeriod
                                      and aic.project = @project
                                      and aic.pjt_entity = @pjt_entity
                                      and aic.acct = @acct)
        SET @error = @@ERROR
        IF @error <> 0
            BREAK

        FETCH NEXT FROM bf_Cursor
            INTO @project, @pjt_entity, @acct, @amount_bf, @ProjCury_amount_bf, @ProjCuryID
    END
    CLOSE bf_Cursor

    IF @error <> 0
        BREAK
    ELSE
        SET @periodNbr = @periodNbr + 1
END

DEALLOCATE bf_Cursor

RETURN(@error)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJYTDAIC_BalanceForward] TO [MSDSL]
    AS [dbo];

