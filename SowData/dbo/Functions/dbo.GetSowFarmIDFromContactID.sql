CREATE FUNCTION [dbo].[GetSowFarmIDFromContactID] 
     (@InputContactID varchar(6), @InputDate as smalldatetime)  
RETURNS Varchar(8)
AS
	BEGIN 
		DECLARE @FarmID varchar(8)
		SET @FarmID = (SELECT TOP 1 FarmID FROM FarmSetup fs
					WHERE ContactID = @InputContactID
					AND EffectiveWeekOfDate = (Select Max(EffectiveWeekOfDate) 
						From FarmSetup WHERE FarmID = fs.FarmID 
						AND EffectiveWeekOfDate <= @InputDate)
					ORDER BY EffectiveWeekOfDate DESC)
		RETURN @FarmID
	END
