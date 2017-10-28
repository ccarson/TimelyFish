CREATE VIEW [vPM2_SowsAndGiltsCulledBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, RemovalWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM SowParityTemp Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= RemovalDate),s.InitialParity)
		FROM SowTemp s WITH (NOLOCK)
		WHERE RemovalType = 'CULL'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowsAndGiltsCulledBase] TO [se\analysts]
    AS [dbo];

