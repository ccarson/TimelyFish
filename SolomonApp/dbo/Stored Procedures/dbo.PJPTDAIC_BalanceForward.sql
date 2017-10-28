
CREATE PROC [dbo].[PJPTDAIC_BalanceForward] (
                @screen CHAR (8),
                @user CHAR (10),
                @period CHAR (6)) AS

-- This stored proc will set balance forward amount field for the fiscal year following the period passed.
-- It will update the balance forward field if the record exists
-- It will create a new record with the balance forward field populated if the record does not exist

SET NOCOUNT ON

DECLARE @newfsyear_num AS CHAR(4)
DECLARE @today SMALLDATETIME

-- The assumption is that the period passed is the final period of the year.
-- Check this by looking for the number of periods configured in GL
IF (SELECT NbrPer FROM GLSetup WITH (NOLOCK)) <> CAST(RIGHT(@period, 2) AS SMALLINT)
    RETURN(0)

SET @newfsyear_num = CAST(CAST(LEFT(@period, 4) AS SMALLINT) + 1 AS CHAR(4))    -- Add a year to the year @period
SET @today = CONVERT(SMALLDATETIME, GETDATE())

-- Another assumption is that the Indirect Rate Calculator and Allocation Processor have been run for period passed.
-- We have no way to confirm this in this proc.
-- So if these have not been run, the balance forward amount will simply be the balance forward amount from the previous fiscal year.
-- The balance forward amount from the previous year will be zero if the project started this year.

-- We need to create/update records in the new period for each project, task, and account category that exists for the current period.
-- The balance forward amount is the sum of the previous years balance forward amount and period amounts.

-- if it exists, update it
UPDATE aic
    SET aic.amount_bf = prevaic.amount_bf
                        + prevaic.amount_01 + prevaic.amount_02 + prevaic.amount_03 + prevaic.amount_04 + prevaic.amount_05
                        + prevaic.amount_06 + prevaic.amount_07 + prevaic.amount_08 + prevaic.amount_09 + prevaic.amount_10
                        + prevaic.amount_11 + prevaic.amount_12 + prevaic.amount_13 + prevaic.amount_14 + prevaic.amount_15,
        aic.ProjCury_amount_bf = prevaic.ProjCury_amount_bf
                        + prevaic.ProjCury_amount_01 + prevaic.ProjCury_amount_02 + prevaic.ProjCury_amount_03 + prevaic.ProjCury_amount_04 + prevaic.ProjCury_amount_05
                        + prevaic.ProjCury_amount_06 + prevaic.ProjCury_amount_07 + prevaic.ProjCury_amount_08 + prevaic.ProjCury_amount_09 + prevaic.ProjCury_amount_10
                        + prevaic.ProjCury_amount_11 + prevaic.ProjCury_amount_12 + prevaic.ProjCury_amount_13 + prevaic.ProjCury_amount_14 + prevaic.ProjCury_amount_15,                        
        aic.lupd_datetime = @today, aic.lupd_prog = @screen, aic.lupd_user = @user
    FROM PJPTDAIC prevaic WITH (NOLOCK)
    INNER JOIN PJPROJ p WITH (NOLOCK)
        ON p.project = prevaic.project
    JOIN PJPTDAIC AS aic
        ON aic.fsyear_num = @newfsyear_num
            and aic.project = prevaic.project
            and aic.pjt_entity = prevaic.pjt_entity
            and aic.acct = prevaic.acct
            and (aic.amount_bf <> prevaic.amount_bf
                                + prevaic.amount_01 + prevaic.amount_02 + prevaic.amount_03 + prevaic.amount_04 + prevaic.amount_05
                                + prevaic.amount_06 + prevaic.amount_07 + prevaic.amount_08 + prevaic.amount_09 + prevaic.amount_10
                                + prevaic.amount_11 + prevaic.amount_12 + prevaic.amount_13 + prevaic.amount_14 + prevaic.amount_15
                 OR aic.ProjCury_amount_bf <> prevaic.ProjCury_amount_bf
                                + prevaic.ProjCury_amount_01 + prevaic.ProjCury_amount_02 + prevaic.ProjCury_amount_03 + prevaic.ProjCury_amount_04 + prevaic.ProjCury_amount_05
                                + prevaic.ProjCury_amount_06 + prevaic.ProjCury_amount_07 + prevaic.ProjCury_amount_08 + prevaic.ProjCury_amount_09 + prevaic.ProjCury_amount_10
                                + prevaic.ProjCury_amount_11 + prevaic.ProjCury_amount_12 + prevaic.ProjCury_amount_13 + prevaic.ProjCury_amount_14 + prevaic.ProjCury_amount_15)
    WHERE prevaic.fsyear_num = LEFT(@period, 4)
IF @@ERROR <> 0
    RETURN(@@ERROR)

-- if it does not exist, create it
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
    [ProjCury_amount_bf], [ProjCuryId], [ProjCuryMultiDiv_01], [ProjCuryMultiDiv_02], [ProjCuryMultiDiv_03], 
    [ProjCuryMultiDiv_04], [ProjCuryMultiDiv_05], [ProjCuryMultiDiv_06], [ProjCuryMultiDiv_07], [ProjCuryMultiDiv_08], 
    [ProjCuryMultiDiv_09], [ProjCuryMultiDiv_10], [ProjCuryMultiDiv_11], [ProjCuryMultiDiv_12], [ProjCuryMultiDiv_13], 
    [ProjCuryMultiDiv_14], [ProjCuryMultiDiv_15], [ProjCuryRate_01], [ProjCuryRate_02], [ProjCuryRate_03], 
    [ProjCuryRate_04], [ProjCuryRate_05], [ProjCuryRate_06], [ProjCuryRate_07], [ProjCuryRate_08], 
    [ProjCuryRate_09], [ProjCuryRate_10], [ProjCuryRate_11], [ProjCuryRate_12], [ProjCuryRate_13], 
    [ProjCuryRate_14], [ProjCuryRate_15], [project],
    [rate_01], [rate_02], [rate_03], [rate_04], [rate_05],
    [rate_06], [rate_07], [rate_08], [rate_09], [rate_10],
    [rate_11], [rate_12], [rate_13], [rate_14], [rate_15])
    SELECT prevaic.acct,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            prevaic.amount_bf
                + prevaic.amount_01 + prevaic.amount_02 + prevaic.amount_03 + prevaic.amount_04 + prevaic.amount_05
                + prevaic.amount_06 + prevaic.amount_07 + prevaic.amount_08 + prevaic.amount_09 + prevaic.amount_10
                + prevaic.amount_11 + prevaic.amount_12 + prevaic.amount_13 + prevaic.amount_14 + prevaic.amount_15,
            @today, @screen, @user,
            @newfsyear_num,
            @today, @screen, @user,
            prevaic.pjt_entity, 
            0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 
            prevaic.ProjCury_amount_bf
                + prevaic.ProjCury_amount_01 + prevaic.ProjCury_amount_02 + prevaic.ProjCury_amount_03 + prevaic.ProjCury_amount_04 + prevaic.ProjCury_amount_05
                + prevaic.ProjCury_amount_06 + prevaic.ProjCury_amount_07 + prevaic.ProjCury_amount_08 + prevaic.ProjCury_amount_09 + prevaic.ProjCury_amount_10
                + prevaic.ProjCury_amount_11 + prevaic.ProjCury_amount_12 + prevaic.ProjCury_amount_13 + prevaic.ProjCury_amount_14 + prevaic.ProjCury_amount_15, 
            p.ProjCuryId, SPACE(0), SPACE(0), SPACE(0), 
            SPACE(0), SPACE(0), SPACE(0), SPACE(0), SPACE(0), 
            SPACE(0), SPACE(0), SPACE(0), SPACE(0), SPACE(0), 
            SPACE(0), SPACE(0), 0, 0, 0, 
            0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 
            0, 0, prevaic.project,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        FROM PJPTDAIC prevaic WITH (NOLOCK)
        INNER JOIN PJPROJ p WITH (NOLOCK)
            ON p.project = prevaic.project
        WHERE prevaic.fsyear_num = LEFT(@period, 4)
            AND (prevaic.amount_bf
                + prevaic.amount_01 + prevaic.amount_02 + prevaic.amount_03 + prevaic.amount_04 + prevaic.amount_05
                + prevaic.amount_06 + prevaic.amount_07 + prevaic.amount_08 + prevaic.amount_09 + prevaic.amount_10
                + prevaic.amount_11 + prevaic.amount_12 + prevaic.amount_13 + prevaic.amount_14 + prevaic.amount_15 <> 0
                OR prevaic.ProjCury_amount_bf
                + prevaic.ProjCury_amount_01 + prevaic.ProjCury_amount_02 + prevaic.ProjCury_amount_03 + prevaic.ProjCury_amount_04 + prevaic.ProjCury_amount_05
                + prevaic.ProjCury_amount_06 + prevaic.ProjCury_amount_07 + prevaic.ProjCury_amount_08 + prevaic.ProjCury_amount_09 + prevaic.ProjCury_amount_10
                + prevaic.ProjCury_amount_11 + prevaic.ProjCury_amount_12 + prevaic.ProjCury_amount_13 + prevaic.ProjCury_amount_14 + prevaic.ProjCury_amount_15 <> 0)
                
            AND NOT EXISTS (SELECT TOP 1 *
                            FROM PJPTDAIC aic WITH (NOLOCK)
                            WHERE aic.fsyear_num = @newfsyear_num
                                and aic.project = prevaic.project
                                and aic.pjt_entity = prevaic.pjt_entity
                                and aic.acct = prevaic.acct)
RETURN(@@ERROR)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDAIC_BalanceForward] TO [MSDSL]
    AS [dbo];

