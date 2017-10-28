 -- ********************************************************************************
-- Copyright Solomon Software, Inc. 1999-2003 All Rights Reserved
-- Proc Name: Delete_RefNumAR
-- Narrative: Deletes a reference number and updates ARSetup.
-- Inputs   : Reference Number
-- Called by: 08.010.00 Front-end screen's Update1_delete event
-- Author: FMG Group
-- Date Created: 1999-12-27
-- Revision details:
-- Date:         2000-07-17
-- Details:      Modified in-sync with UpdateLastRefnbr routine
-- *********************************************************************************

CREATE proc Delete_RefNumAR @parm1 varchar ( 10) As

DECLARE	@MinNbr     CHAR(10)
DECLARE @NumPart    VARCHAR(10)
DECLARE @AlphaPart  VARCHAR( 2)
DECLARE @LastRefNbr VARCHAR(10)

SELECT @LastRefnbr = LastRefNbr
  FROM ARSetup (NOLOCK)

DELETE RefNbr
  FROM RefNbr
 WHERE RefNbr.Refnbr = @parm1
IF @@ERROR<>0 RETURN

IF EXISTS(SELECT * FROM ARSetup WHERE SetupID='AR' AND AutoRef=1)
   AND @Parm1 IS NOT NULL AND @Parm1<>''
BEGIN

   SELECT @MinNbr = @parm1

    --Validate for first two digits of alpha charecters in the refnbr
    IF ISNUMERIC(@MinNbr) <> 1
        IF ISNUMERIC(LEFT( @MinNbr, 2)) <> 1
           IF ISNUMERIC(LEFT( @MinNbr, 1)) <> 1 AND ISNUMERIC(SUBSTRING( @MinNbr, 2,1)) = 1
              SELECT @NumPart  =  SUBSTRING( @MinNbr, 2, LEN(@MinNbr)), @AlphaPart = LEFT(@MinNbr,1)
           ELSE
              SELECT @NumPart  =  SUBSTRING( @MinNbr, 3, LEN(@MinNbr)), @AlphaPart = LEFT(@MinNbr,2)
        ELSE
              --Some digit other than the 2 left most one is alpha. Bad refnbr. It should not happen.
              SELECT @NumPart = ''
    ELSE
        SELECT @NumPart = @MinNbr, @AlphaPart = ''

    -- we don't need to check whether @MinNbr is Null or blank, because Solomon enforces MinNbr to be
    -- non-blank string.

    IF LTRIM(RTRIM(@MinNbr)) = LTRIM(RTRIM(@LastRefNbr)) And @NumPart <> ''
    BEGIN
       IF @AlphaPart <> ''
          SELECT @MinNbr = LTRIM(STR(CAST(@NumPart AS NUMERIC)-1))
       ELSE
          SELECT @MinNbr = LTRIM(STR(CAST(@LastRefNbr AS NUMERIC)-1))

       UPDATE ARSetup
          SET LastRefNbr= @AlphaPart + REPLICATE('0', LEN(LastRefNbr) - LEN(@MinNbr) - LEN(@AlphaPart)) + @MinNbr
        WHERE SetupID='AR'
    END
END


