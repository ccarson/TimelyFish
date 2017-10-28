CREATE VIEW [vPM2_NumberOfLittersWeaned] (FarmID, WeekOfDate, SowGenetics, SowParity, Qty)
	As 
	-- Does not include NURSE OFF or PART WEAN
	SELECT FarmID, WeekOfDate, SowGenetics, SowParity, Count(*)
	FROM SowWeanEventTemp WITH (NOLOCK)
	WHERE EventType = 'WEAN'
	GROUP BY FarmID, WeekOfDate, SowGenetics, SowParity

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_NumberOfLittersWeaned] TO [se\analysts]
    AS [dbo];

