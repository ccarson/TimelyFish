
CREATE PROC [dbo].[PJACTROL_BalanceForward] (
                @screen CHAR (8),
                @user CHAR (10),
                @period CHAR (6)) AS

-- This stored proc will set balance forward amount and units fields for the fiscal year following the period passed.
-- It will update the balance forward fields if the record exists
-- It will create a new record with the balance forward fields populated if the record does not exist

SET NOCOUNT ON

DECLARE @prevfsyear_num AS CHAR(4) = LEFT(@period, 4)
DECLARE @fsyear_num AS CHAR(4) = CAST(CAST(@prevfsyear_num AS SMALLINT) + 1 AS CHAR(4))    -- Add a year
DECLARE @today SMALLDATETIME = CONVERT(SMALLDATETIME, GETDATE())

-- The assumption is that the period passed is the final period of the year.
-- Check this by looking for the number of periods configured in GL
IF (SELECT NbrPer FROM GLSetup WITH (NOLOCK)) <> CAST(RIGHT(@period, 2) AS SMALLINT)
    RETURN(0)

-- We need to create/update records in the new period for each project and account category that exists for the current period.
-- The balance forward amount is the sum of the previous years balance forward amount and the period amounts.
-- The balance forward units is the sum of the previous years balance forward units and the period units.

-- if it exists, update it
UPDATE actrol
    SET actrol.amount_bf = prevactrol.amount_bf
                           + prevactrol.amount_01 + prevactrol.amount_02 + prevactrol.amount_03 + prevactrol.amount_04 + prevactrol.amount_05
                           + prevactrol.amount_06 + prevactrol.amount_07 + prevactrol.amount_08 + prevactrol.amount_09 + prevactrol.amount_10
                           + prevactrol.amount_11 + prevactrol.amount_12 + prevactrol.amount_13 + prevactrol.amount_14 + prevactrol.amount_15,
	    actrol.units_bf = prevactrol.units_bf
                          + prevactrol.units_01 + prevactrol.units_02 + prevactrol.units_03 + prevactrol.units_04 + prevactrol.units_05
                          + prevactrol.units_06 + prevactrol.units_07 + prevactrol.units_08 + prevactrol.units_09 + prevactrol.units_10
                          + prevactrol.units_11 + prevactrol.units_12 + prevactrol.units_13 + prevactrol.units_14 + prevactrol.units_15,
        actrol.ProjCury_amount_bf = prevactrol.ProjCury_amount_bf
                          + prevactrol.ProjCury_amount_01 + prevactrol.ProjCury_amount_02 + prevactrol.ProjCury_amount_03 + prevactrol.ProjCury_amount_04 + prevactrol.ProjCury_amount_05
                          + prevactrol.ProjCury_amount_06 + prevactrol.ProjCury_amount_07 + prevactrol.ProjCury_amount_08 + prevactrol.ProjCury_amount_09 + prevactrol.ProjCury_amount_10
                          + prevactrol.ProjCury_amount_11 + prevactrol.ProjCury_amount_12 + prevactrol.ProjCury_amount_13 + prevactrol.ProjCury_amount_14 + prevactrol.ProjCury_amount_15,    
        actrol.lupd_datetime = @today, actrol.lupd_prog = @screen, actrol.lupd_user = @user
    FROM PJACTROL prevactrol WITH (NOLOCK)
    INNER JOIN PJPROJ p WITH (NOLOCK)
        ON p.project = prevactrol.project
          AND p.bf_values_switch = 'Y'
    INNER JOIN PJACTROL AS actrol
        ON actrol.fsyear_num = @fsyear_num
          AND actrol.project = prevactrol.project
          AND actrol.acct = prevactrol.acct
          AND (actrol.amount_bf <> prevactrol.amount_bf
                                   + prevactrol.amount_01 + prevactrol.amount_02 + prevactrol.amount_03 + prevactrol.amount_04 + prevactrol.amount_05
                                   + prevactrol.amount_06 + prevactrol.amount_07 + prevactrol.amount_08 + prevactrol.amount_09 + prevactrol.amount_10
                                   + prevactrol.amount_11 + prevactrol.amount_12 + prevactrol.amount_13 + prevactrol.amount_14 + prevactrol.amount_15
			    OR actrol.units_bf <> prevactrol.units_bf
                                + prevactrol.units_01 + prevactrol.units_02 + prevactrol.units_03 + prevactrol.units_04 + prevactrol.units_05
                                + prevactrol.units_06 + prevactrol.units_07 + prevactrol.units_08 + prevactrol.units_09 + prevactrol.units_10
                                + prevactrol.units_11 + prevactrol.units_12 + prevactrol.units_13 + prevactrol.units_14 + prevactrol.units_15
                OR actrol.ProjCury_amount_bf <> prevactrol.ProjCury_amount_bf
                                + prevactrol.ProjCury_amount_01 + prevactrol.ProjCury_amount_02 + prevactrol.ProjCury_amount_03 + prevactrol.ProjCury_amount_04 + prevactrol.ProjCury_amount_05
                                + prevactrol.ProjCury_amount_06 + prevactrol.ProjCury_amount_07 + prevactrol.ProjCury_amount_08 + prevactrol.ProjCury_amount_09 + prevactrol.ProjCury_amount_10
                                + prevactrol.ProjCury_amount_11 + prevactrol.ProjCury_amount_12 + prevactrol.ProjCury_amount_13 + prevactrol.ProjCury_amount_14 + prevactrol.ProjCury_amount_15)
    WHERE prevactrol.fsyear_num = @prevfsyear_num
IF @@ERROR <> 0
    RETURN(@@ERROR)

-- if it does not exist, create it
INSERT INTO PJACTROL (
    [acct],
    [amount_01], [amount_02], [amount_03], [amount_04], [amount_05],
    [amount_06], [amount_07], [amount_08], [amount_09], [amount_10],
    [amount_11], [amount_12], [amount_13], [amount_14], [amount_15],
    [amount_bf],
    [crtd_datetime], [crtd_prog], [crtd_user],
    [data1], [fsyear_num],
    [lupd_datetime], [lupd_prog], [lupd_user],
    [ProjCury_amount_01], [ProjCury_amount_02], [ProjCury_amount_03], [ProjCury_amount_04], [ProjCury_amount_05], 
    [ProjCury_amount_06], [ProjCury_amount_07], [ProjCury_amount_08], [ProjCury_amount_09], [ProjCury_amount_10], 
    [ProjCury_amount_11], [ProjCury_amount_12], [ProjCury_amount_13], [ProjCury_amount_14], [ProjCury_amount_15], 
    [ProjCury_amount_bf], [project],
    [units_01], [units_02], [units_03], [units_04], [units_05],
    [units_06], [units_07], [units_08], [units_09], [units_10],
    [units_11], [units_12], [units_13], [units_14], [units_15],
    [units_bf])
    SELECT prevactrol.acct,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           prevactrol.amount_bf
           + prevactrol.amount_01 + prevactrol.amount_02 + prevactrol.amount_03 + prevactrol.amount_04 + prevactrol.amount_05
           + prevactrol.amount_06 + prevactrol.amount_07 + prevactrol.amount_08 + prevactrol.amount_09 + prevactrol.amount_10
           + prevactrol.amount_11 + prevactrol.amount_12 + prevactrol.amount_13 + prevactrol.amount_14 + prevactrol.amount_15,
           @today, @screen, @user,
           SPACE(0), @fsyear_num,
           @today, @screen, @user,
		   0, 0, 0, 0, 0, 
           0, 0, 0, 0, 0, 
           0, 0, 0, 0, 0, 
            prevactrol.ProjCury_amount_bf
                + prevactrol.ProjCury_amount_01 + prevactrol.ProjCury_amount_02 + prevactrol.ProjCury_amount_03 + prevactrol.ProjCury_amount_04 + prevactrol.ProjCury_amount_05
                + prevactrol.ProjCury_amount_06 + prevactrol.ProjCury_amount_07 + prevactrol.ProjCury_amount_08 + prevactrol.ProjCury_amount_09 + prevactrol.ProjCury_amount_10
                + prevactrol.ProjCury_amount_11 + prevactrol.ProjCury_amount_12 + prevactrol.ProjCury_amount_13 + prevactrol.ProjCury_amount_14 + prevactrol.ProjCury_amount_15, 
           prevactrol.project,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           prevactrol.units_bf
           + prevactrol.units_01 + prevactrol.units_02 + prevactrol.units_03 + prevactrol.units_04 + prevactrol.units_05
           + prevactrol.units_06 + prevactrol.units_07 + prevactrol.units_08 + prevactrol.units_09 + prevactrol.units_10
           + prevactrol.units_11 + prevactrol.units_12 + prevactrol.units_13 + prevactrol.units_14 + prevactrol.units_15
        FROM PJACTROL prevactrol WITH (NOLOCK)
        INNER JOIN PJPROJ p WITH (NOLOCK)
            ON p.project = prevactrol.project
              AND p.bf_values_switch = 'Y'
        WHERE prevactrol.fsyear_num = @prevfsyear_num
            AND (prevactrol.amount_bf
                 + prevactrol.amount_01 + prevactrol.amount_02 + prevactrol.amount_03 + prevactrol.amount_04 + prevactrol.amount_05
                 + prevactrol.amount_06 + prevactrol.amount_07 + prevactrol.amount_08 + prevactrol.amount_09 + prevactrol.amount_10
                 + prevactrol.amount_11 + prevactrol.amount_12 + prevactrol.amount_13 + prevactrol.amount_14 + prevactrol.amount_15 <> 0
			   OR prevactrol.units_bf
                 + prevactrol.units_01 + prevactrol.units_02 + prevactrol.units_03 + prevactrol.units_04 + prevactrol.units_05
                 + prevactrol.units_06 + prevactrol.units_07 + prevactrol.units_08 + prevactrol.units_09 + prevactrol.units_10
                 + prevactrol.units_11 + prevactrol.units_12 + prevactrol.units_13 + prevactrol.units_14 + prevactrol.units_15 <> 0
               OR prevactrol.ProjCury_amount_bf
                 + prevactrol.ProjCury_amount_01 + prevactrol.ProjCury_amount_02 + prevactrol.ProjCury_amount_03 + prevactrol.ProjCury_amount_04 + prevactrol.ProjCury_amount_05
                 + prevactrol.ProjCury_amount_06 + prevactrol.ProjCury_amount_07 + prevactrol.ProjCury_amount_08 + prevactrol.ProjCury_amount_09 + prevactrol.ProjCury_amount_10
                 + prevactrol.ProjCury_amount_11 + prevactrol.ProjCury_amount_12 + prevactrol.ProjCury_amount_13 + prevactrol.ProjCury_amount_14 + prevactrol.ProjCury_amount_15 <> 0)
            
			AND NOT EXISTS (SELECT TOP 1 *
                                FROM PJACTROL actrol WITH (NOLOCK)
                                WHERE actrol.fsyear_num = @fsyear_num
                                    AND actrol.project = prevactrol.project
                                    AND actrol.acct = prevactrol.acct)
RETURN(@@ERROR)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACTROL_BalanceForward] TO [MSDSL]
    AS [dbo];

