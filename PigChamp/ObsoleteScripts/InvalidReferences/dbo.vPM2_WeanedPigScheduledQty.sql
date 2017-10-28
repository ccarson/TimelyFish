
--------------------------------------------------------------------------------------------------------------------
-- Summary of vWeanPigScheduleDetail detail view for total estimated pig counts by week
-- This information is loaded into Essbase
-- NOTE: 
--------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[vPM2_WeanedPigScheduledQty]
	(FarmID, WeekOfDate, Qty)
	AS
	SELECT FarmID, WeekOfDate, Sum(EstimatedQty)
	FROM vWeanPigScheduleDetail
	GROUP BY FarmID, WeekOfDate


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_WeanedPigScheduledQty] TO [se\analysts]
    AS [dbo];

