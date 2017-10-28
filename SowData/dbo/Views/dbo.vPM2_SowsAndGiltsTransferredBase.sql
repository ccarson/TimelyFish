CREATE VIEW [vPM2_SowsAndGiltsTransferredBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, RemovalWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM SowParityTemp Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= RemovalDate),s.InitialParity)
		FROM SowTemp s WITH (NOLOCK)
		WHERE RemovalType = 'TRANSFER'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_SowsAndGiltsTransferredBase] TO [se\analysts]
    AS [dbo];

