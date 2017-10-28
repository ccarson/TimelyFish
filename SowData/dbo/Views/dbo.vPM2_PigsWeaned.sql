CREATE VIEW [vPM2_PigsWeaned] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As
 SELECT FarmID, WeekOfDate, SowGenetics, SowParity, sum(qty)
	FROM SowWeanEventTemp WITH (NOLOCK)
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_PigsWeaned] TO [se\analysts]
    AS [dbo];

