CREATE FUNCTION [dbo].[CalcDistance] 
     (@Start as int, @End as int)  
RETURNS DECIMAL(10,2) 
AS
	BEGIN 
	DECLARE @pdecReturn DECIMAL(10,2)
	SET @pDecReturn=(Select OneWayMiles from vContactMilesMatrix where SourceSite=@Start and DestSite=@End)

	 RETURN @pdecReturn
	END
