CREATE VIEW [vPM2_FemalesEnteredBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, EntryWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM SowParityTemp Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= EntryDate),s.InitialParity)
		FROM SowTemp s WITH (NOLOCK)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_FemalesEnteredBase] TO [se\analysts]
    AS [dbo];

