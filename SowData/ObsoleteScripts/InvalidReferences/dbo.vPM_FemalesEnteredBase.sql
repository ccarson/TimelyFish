CREATE VIEW [dbo].[vPM_FemalesEnteredBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, EntryWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM dbo.SowParity Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= EntryDate),s.InitialParity)
		FROM dbo.Sow s

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_FemalesEnteredBase] TO [se\analysts]
    AS [dbo];

