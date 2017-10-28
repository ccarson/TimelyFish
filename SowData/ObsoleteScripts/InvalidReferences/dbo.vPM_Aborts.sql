CREATE VIEW [dbo].[vPM_Aborts] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
 	SELECT sfe.FarmID, sfe.WeekOfDate, sfe.SowGenetics, sfe.SowParity, Count(*)
	FROM dbo.SowFalloutEvent sfe
	GROUP BY sfe.FarmID, sfe.WeekOfDate, sfe.SowGenetics, sfe.SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_Aborts] TO [se\analysts]
    AS [dbo];

