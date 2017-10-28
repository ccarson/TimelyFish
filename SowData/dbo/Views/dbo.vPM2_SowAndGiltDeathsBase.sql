CREATE VIEW [vPM2_SowAndGiltDeathsBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, RemovalWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM SowParityTemp Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= RemovalDate),s.InitialParity)
		FROM SowTemp s WITH (NOLOCK)
		WHERE RemovalType In('DEATH','DESTROYED') 

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowAndGiltDeathsBase] TO [se\analysts]
    AS [dbo];

