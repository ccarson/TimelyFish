CREATE VIEW [dbo].[vPM_SowsAndGiltsCulledBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, RemovalWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM dbo.SowParity Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= RemovalDate),s.InitialParity)
		FROM dbo.Sow s
		WHERE RemovalType = 'CULL'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowsAndGiltsCulledBase] TO [se\analysts]
    AS [dbo];

