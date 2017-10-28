CREATE VIEW vPM2_SowFeed (FarmID, WeekOfDate, SowGenetics, SowParity, Acct, Qty)
	AS
	SELECT FarmID, WeekOfDate, 'NOGENETICS','NO PARITY', 'R_' + InvtIDDel, Sum(QtyDel)
	FROM vSowFeedDetail
	GROUP BY FarmID, WeekOfDate, InvtIDDel

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowFeed] TO [se\analysts]
    AS [dbo];

