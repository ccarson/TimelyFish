
--------------------------------------------------------------------------------------------------------------------
-- Summary of transport detail view for total weaned pig counts by source, destination and recount
-- This information is loaded into Essbase
-- NOTE: 
--------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[vPM2_TransportPigQtys]
	(FarmID, WeekOfDate, SourceQty, DestQty, RecountQty)
	AS
	SELECT FarmID, WeekOfDate, Sum(SourceQty), Sum(DestQty), Sum(RecountQty)
	FROM vTransportDetail
	GROUP BY FarmID, WeekOfDate



GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_TransportPigQtys] TO [se\analysts]
    AS [dbo];

