--------------------------------------------------------------------------------------------------------------------
-- Summary of vPigletFarrowInventory detail view for total farrow house piglet inventory by week
-- This information is loaded into Essbase
-- NOTE: 
--------------------------------------------------------------------------------------------------------------------
CREATE VIEW vPM2_PigletFarrowInventory
	(FarmID, WeekOfDate, Qty)
	AS
	SELECT FarmID, WeekOfDate,Sum(Qty)
	FROM vPigletFarrowInventory 
	GROUP BY FarmID, WeekOfDate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigletFarrowInventory] TO [se\analysts]
    AS [dbo];

