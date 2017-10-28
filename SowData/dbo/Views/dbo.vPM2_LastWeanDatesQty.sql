CREATE VIEW [vPM2_LastWeanDatesQty] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	AS
	--  Count of Sows with last wean date in period
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM vPM2_LastWeaningsBase WITH (NOLOCK)
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity	

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_LastWeanDatesQty] TO [se\analysts]
    AS [dbo];

