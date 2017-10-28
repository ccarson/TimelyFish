
CREATE PROC [dbo].[PJACTSUM_BalanceForward] (
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

-- We need to create/update records in the new period for each project, task, and account category that exists for the current period.
-- The balance forward amount is the sum of the previous years balance forward amount and the period amounts.
-- The balance forward units is the sum of the previous years balance forward units and the period units.

-- if it exists, update it
UPDATE actsum
    SET actsum.amount_bf = prevactsum.amount_bf
                           + prevactsum.amount_01 + prevactsum.amount_02 + prevactsum.amount_03 + prevactsum.amount_04 + prevactsum.amount_05
                           + prevactsum.amount_06 + prevactsum.amount_07 + prevactsum.amount_08 + prevactsum.amount_09 + prevactsum.amount_10
                           + prevactsum.amount_11 + prevactsum.amount_12 + prevactsum.amount_13 + prevactsum.amount_14 + prevactsum.amount_15,
		actsum.units_bf = prevactsum.units_bf
                          + prevactsum.units_01 + prevactsum.units_02 + prevactsum.units_03 + prevactsum.units_04 + prevactsum.units_05
                          + prevactsum.units_06 + prevactsum.units_07 + prevactsum.units_08 + prevactsum.units_09 + prevactsum.units_10
                          + prevactsum.units_11 + prevactsum.units_12 + prevactsum.units_13 + prevactsum.units_14 + prevactsum.units_15,
        actsum.ProjCury_amount_bf = prevactsum.ProjCury_amount_bf
                        + prevactsum.ProjCury_amount_01 + prevactsum.ProjCury_amount_02 + prevactsum.ProjCury_amount_03 + prevactsum.ProjCury_amount_04 + prevactsum.ProjCury_amount_05
                        + prevactsum.ProjCury_amount_06 + prevactsum.ProjCury_amount_07 + prevactsum.ProjCury_amount_08 + prevactsum.ProjCury_amount_09 + prevactsum.ProjCury_amount_10
                        + prevactsum.ProjCury_amount_11 + prevactsum.ProjCury_amount_12 + prevactsum.ProjCury_amount_13 + prevactsum.ProjCury_amount_14 + prevactsum.ProjCury_amount_15,   
        actsum.lupd_datetime = @today, actsum.lupd_prog = @screen, actsum.lupd_user = @user
    FROM PJACTSUM prevactsum WITH (NOLOCK)
    INNER JOIN PJPROJ p WITH (NOLOCK)
        ON p.project = prevactsum.project
          AND p.bf_values_switch = 'Y'
    INNER JOIN PJACTSUM AS actsum
        ON actsum.fsyear_num = @fsyear_num
          AND actsum.project = prevactsum.project
          AND actsum.pjt_entity = prevactsum.pjt_entity
          AND actsum.acct = prevactsum.acct
          AND (actsum.amount_bf <> prevactsum.amount_bf
                                   + prevactsum.amount_01 + prevactsum.amount_02 + prevactsum.amount_03 + prevactsum.amount_04 + prevactsum.amount_05
                                   + prevactsum.amount_06 + prevactsum.amount_07 + prevactsum.amount_08 + prevactsum.amount_09 + prevactsum.amount_10
                                   + prevactsum.amount_11 + prevactsum.amount_12 + prevactsum.amount_13 + prevactsum.amount_14 + prevactsum.amount_15
               OR actsum.units_bf <> prevactsum.units_bf
                                     + prevactsum.units_01 + prevactsum.units_02 + prevactsum.units_03 + prevactsum.units_04 + prevactsum.units_05
                                     + prevactsum.units_06 + prevactsum.units_07 + prevactsum.units_08 + prevactsum.units_09 + prevactsum.units_10
                                     + prevactsum.units_11 + prevactsum.units_12 + prevactsum.units_13 + prevactsum.units_14 + prevactsum.units_15
               OR actsum.ProjCury_amount_bf <> prevactsum.ProjCury_amount_bf
                        + prevactsum.ProjCury_amount_01 + prevactsum.ProjCury_amount_02 + prevactsum.ProjCury_amount_03 + prevactsum.ProjCury_amount_04 + prevactsum.ProjCury_amount_05
                        + prevactsum.ProjCury_amount_06 + prevactsum.ProjCury_amount_07 + prevactsum.ProjCury_amount_08 + prevactsum.ProjCury_amount_09 + prevactsum.ProjCury_amount_10
                        + prevactsum.ProjCury_amount_11 + prevactsum.ProjCury_amount_12 + prevactsum.ProjCury_amount_13 + prevactsum.ProjCury_amount_14 + prevactsum.ProjCury_amount_15)
    WHERE prevactsum.fsyear_num = @prevfsyear_num
IF @@ERROR <> 0
    RETURN(@@ERROR)

-- if it does not exist, create it
INSERT INTO PJACTSUM (
    [acct],
    [amount_01], [amount_02], [amount_03], [amount_04], [amount_05],
    [amount_06], [amount_07], [amount_08], [amount_09], [amount_10],
    [amount_11], [amount_12], [amount_13], [amount_14], [amount_15],
    [amount_bf],
    [crtd_datetime], [crtd_prog], [crtd_user],
    [data1], [fsyear_num],
    [lupd_datetime], [lupd_prog], [lupd_user],
    [pjt_entity], 
	[ProjCury_amount_01], [ProjCury_amount_02], [ProjCury_amount_03], [ProjCury_amount_04], [ProjCury_amount_05], 
    [ProjCury_amount_06], [ProjCury_amount_07], [ProjCury_amount_08], [ProjCury_amount_09], [ProjCury_amount_10], 
    [ProjCury_amount_11], [ProjCury_amount_12], [ProjCury_amount_13], [ProjCury_amount_14], [ProjCury_amount_15], 
    [ProjCury_amount_bf], [project],
    [units_01], [units_02], [units_03], [units_04], [units_05],
    [units_06], [units_07], [units_08], [units_09], [units_10],
    [units_11], [units_12], [units_13], [units_14], [units_15],
    [units_bf])
    SELECT prevactsum.acct,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           prevactsum.amount_bf
           + prevactsum.amount_01 + prevactsum.amount_02 + prevactsum.amount_03 + prevactsum.amount_04 + prevactsum.amount_05
           + prevactsum.amount_06 + prevactsum.amount_07 + prevactsum.amount_08 + prevactsum.amount_09 + prevactsum.amount_10
           + prevactsum.amount_11 + prevactsum.amount_12 + prevactsum.amount_13 + prevactsum.amount_14 + prevactsum.amount_15,
           @today, @screen, @user,
           SPACE(0), @fsyear_num,
           @today, @screen, @user,
           prevactsum.pjt_entity, 
		    0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 
            prevactsum.ProjCury_amount_bf
                + prevactsum.ProjCury_amount_01 + prevactsum.ProjCury_amount_02 + prevactsum.ProjCury_amount_03 + prevactsum.ProjCury_amount_04 + prevactsum.ProjCury_amount_05
                + prevactsum.ProjCury_amount_06 + prevactsum.ProjCury_amount_07 + prevactsum.ProjCury_amount_08 + prevactsum.ProjCury_amount_09 + prevactsum.ProjCury_amount_10
                + prevactsum.ProjCury_amount_11 + prevactsum.ProjCury_amount_12 + prevactsum.ProjCury_amount_13 + prevactsum.ProjCury_amount_14 + prevactsum.ProjCury_amount_15, 
		   prevactsum.project,
           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
           prevactsum.units_bf
           + prevactsum.units_01 + prevactsum.units_02 + prevactsum.units_03 + prevactsum.units_04 + prevactsum.units_05
           + prevactsum.units_06 + prevactsum.units_07 + prevactsum.units_08 + prevactsum.units_09 + prevactsum.units_10
           + prevactsum.units_11 + prevactsum.units_12 + prevactsum.units_13 + prevactsum.units_14 + prevactsum.units_15
        FROM PJACTSUM prevactsum WITH (NOLOCK)
        INNER JOIN PJPROJ p WITH (NOLOCK)
            ON p.project = prevactsum.project
              AND p.bf_values_switch = 'Y'
        WHERE prevactsum.fsyear_num = @prevfsyear_num
            AND (prevactsum.amount_bf
                 + prevactsum.amount_01 + prevactsum.amount_02 + prevactsum.amount_03 + prevactsum.amount_04 + prevactsum.amount_05
                 + prevactsum.amount_06 + prevactsum.amount_07 + prevactsum.amount_08 + prevactsum.amount_09 + prevactsum.amount_10
                 + prevactsum.amount_11 + prevactsum.amount_12 + prevactsum.amount_13 + prevactsum.amount_14 + prevactsum.amount_15 <> 0
				 OR prevactsum.units_bf
                 + prevactsum.units_01 + prevactsum.units_02 + prevactsum.units_03 + prevactsum.units_04 + prevactsum.units_05
                 + prevactsum.units_06 + prevactsum.units_07 + prevactsum.units_08 + prevactsum.units_09 + prevactsum.units_10
                 + prevactsum.units_11 + prevactsum.units_12 + prevactsum.units_13 + prevactsum.units_14 + prevactsum.units_15 <> 0
                 OR prevactsum.ProjCury_amount_bf
                        + prevactsum.ProjCury_amount_01 + prevactsum.ProjCury_amount_02 + prevactsum.ProjCury_amount_03 + prevactsum.ProjCury_amount_04 + prevactsum.ProjCury_amount_05
                        + prevactsum.ProjCury_amount_06 + prevactsum.ProjCury_amount_07 + prevactsum.ProjCury_amount_08 + prevactsum.ProjCury_amount_09 + prevactsum.ProjCury_amount_10
                        + prevactsum.ProjCury_amount_11 + prevactsum.ProjCury_amount_12 + prevactsum.ProjCury_amount_13 + prevactsum.ProjCury_amount_14 + prevactsum.ProjCury_amount_15 <> 0)  

            AND NOT EXISTS (SELECT TOP 1 *
                                FROM PJACTSUM actsum WITH (NOLOCK)
                                WHERE actsum.fsyear_num = @fsyear_num
                                    AND actsum.project = prevactsum.project
                                    AND actsum.pjt_entity = prevactsum.pjt_entity
                                    AND actsum.acct = prevactsum.acct)
RETURN(@@ERROR)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACTSUM_BalanceForward] TO [MSDSL]
    AS [dbo];

