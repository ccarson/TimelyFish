CREATE VIEW [vPM2_Aborts] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
 	SELECT sfe.FarmID, sfe.WeekOfDate, sfe.SowGenetics, sfe.SowParity, Count(*)
	FROM SowFalloutEventTemp sfe WITH (NOLOCK)
	GROUP BY sfe.FarmID, sfe.WeekOfDate, sfe.SowGenetics, sfe.SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_Aborts] TO [se\analysts]
    AS [dbo];

