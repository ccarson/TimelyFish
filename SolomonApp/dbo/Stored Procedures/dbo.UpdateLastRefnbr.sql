 /********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
** Proc Name: UpdateLastRefnbr
** Narrative: Updates last refnbr in ARSetup whenever a batch is deleted.
*            Copied the logic from pp_08400PrepWrk and modified to suit the current
*            scenario.
** Inputs   : Batch Number
** Outputs  :
** Called by: 0801000 Application Update1_Delete()
** 07-17-2000:    Accounting for first two digits of alpha charecters
**/

CREATE PROCEDURE UpdateLastRefnbr @BatchNbr VARCHAR(6) AS

DECLARE	@MinNbr     VARCHAR(10)
DECLARE @LastRefNbr VARCHAR(10)
DECLARE @NumPart    VARCHAR(10)
DECLARE @AlphaPart  VARCHAR( 2)

SELECT	@MinNbr    = RTRIM(LTRIM(MIN(ard.RefNbr)))
  FROM  ARDoc ard (NOLOCK)
 WHERE  ard.batnbr = @BatchNbr AND ard.RefNbr <> ''

SELECT @LastRefnbr = LastRefNbr
  FROM ARSetup (NOLOCK)

--Validate for first two digits of alpha charecters in the refnbr
IF ISNUMERIC(@MinNbr) <> 1
  IF ISNUMERIC(LEFT( @MinNbr, 2)) <> 1
     IF ISNUMERIC(LEFT( @MinNbr, 1)) <> 1 AND ISNUMERIC(SUBSTRING( @MinNbr, 2,1)) = 1
        SELECT @NumPart  =  SUBSTRING( @MinNbr, 2, LEN(@MinNbr)), @AlphaPart = LEFT(@MinNbr,1)
     ELSE
        SELECT @NumPart  =  SUBSTRING( @MinNbr, 3, LEN(@MinNbr)), @AlphaPart = LEFT(@MinNbr,2)
  ELSE
     --Some digit other than the 2 left most one is alpha. Bad refnbr. It should not happen
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


