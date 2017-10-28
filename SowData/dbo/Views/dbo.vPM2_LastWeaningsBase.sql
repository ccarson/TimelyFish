CREATE VIEW [vPM2_LastWeaningsBase]
	AS 
	SELECT FarmID, SowID, EventDate = Max(EventDate), WeekOfDate = Max(WeekOfDate), SowGenetics, SowParity, Qty = Sum(Qty)
	FROM vPM2_LastWeaningsDetail WITH (NOLOCK)
	GROUP BY FarmID, SowID, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LastWeaningsBase] TO [se\analysts]
    AS [dbo];

