CREATE VIEW [vPM2_EndingFemaleInventory] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
 	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM vPM2_EndingFemaleInventoryBase WITH (NOLOCK)
	GROUP By FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_EndingFemaleInventory] TO [se\analysts]
    AS [dbo];

