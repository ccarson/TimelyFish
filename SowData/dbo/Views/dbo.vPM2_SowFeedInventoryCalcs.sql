CREATE VIEW vPM2_SowFeedInventoryCalcs
	(FarmID, WeekOfDate, Acct, BegInvQty, DelvQty, EndInvQty)
	AS
	SELECT v.FarmID, v.WeekOfDate, Acct=RTrim(v.RationType),
	BegInvQty = Sum(BegBinPounds),
	DelvQty = Sum(DeliveredPounds),
	EndInvQty = Sum(EndBinPounds)
	FROM vFarmBinForEachWeekWithReading v
	GROUP BY v.FarmID, v.WeekOfDate, v.RationType

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowFeedInventoryCalcs] TO [se\analysts]
    AS [dbo];

