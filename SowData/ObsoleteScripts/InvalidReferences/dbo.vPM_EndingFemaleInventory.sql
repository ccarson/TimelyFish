CREATE VIEW [dbo].[vPM_EndingFemaleInventory] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
 	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM dbo.vPM_EndingFemaleInventoryBase
	GROUP By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_EndingFemaleInventory] TO [se\analysts]
    AS [dbo];

