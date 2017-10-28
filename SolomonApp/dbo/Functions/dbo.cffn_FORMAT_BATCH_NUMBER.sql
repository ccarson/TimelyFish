
-- =============================================
-- Author:	Matt Dawson
-- Create date:	10/1/2008
-- Description:	Adds leading zero if needed
-- Parameters: 	@BatchNumber
-- =============================================
Create Function dbo.cffn_FORMAT_BATCH_NUMBER
	(@BatchNumber as char(10))
RETURNS CHAR(10)

AS
BEGIN

SET @BatchNumber = REPLICATE('0',6 - LEN(@BatchNumber)) + @BatchNumber

RETURN @BatchNumber
END
