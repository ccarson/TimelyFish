
CREATE FUNCTION [dbo].[GetSowParity] 
     (@InputFarmID varchar(8), @InputSowID varchar(6), @InputDate as smalldatetime)  
RETURNS SMALLINT
AS
	BEGIN 
		DECLARE @SowParity smallint
		SET @SowParity = (Select Max(Parity) From SowParity 
					Where FarmID = @InputFarmID 
					AND SowID = @InputSowID
					AND EffectiveDate <= @InputDate)
		RETURN @SowParity
	END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSowParity] TO [PRD]
    AS [dbo];

