CREATE VIEW [vPM2_SowsAndGiltsTransferred] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
		FROM vPM2_SowsAndGiltsTransferredBase WITH (NOLOCK)
		GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowsAndGiltsTransferred] TO [se\analysts]
    AS [dbo];

