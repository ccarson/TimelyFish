
-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/7/2008
-- Description:	Gets Actual Rate Per Load
-- Parameters: 	@PMLoadID
-- =============================================
Create Function [dbo].[getActualRate]
	(@PMLoadID as char(6))
RETURNS Decimal(10,2)

AS
BEGIN
DECLARE @Rate decimal(10,2)

SET @Rate = (SELECT SUM(CASE WHEN DocType = 're' 
				THEN AmtTruck * -1 
				ELSE AmtTruck 
			END) 'ActualRate' FROM cftPigSale (NOLOCK) WHERE PMLoadID = @PMLoadID)
RETURN @Rate 
END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[getActualRate] TO [MSDSL]
    AS [dbo];

