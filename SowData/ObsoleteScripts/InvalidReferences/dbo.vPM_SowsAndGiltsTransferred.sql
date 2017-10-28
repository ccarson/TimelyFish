CREATE VIEW [dbo].[vPM_SowsAndGiltsTransferred] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM dbo.vPM_SowsAndGiltsTransferredBase
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowsAndGiltsTransferred] TO [se\analysts]
    AS [dbo];

