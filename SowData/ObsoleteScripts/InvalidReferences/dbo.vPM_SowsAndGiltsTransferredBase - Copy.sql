CREATE VIEW [dbo].[vPM_SowsAndGiltsTransferredBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, RemovalWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM dbo.SowParity Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= RemovalDate),s.InitialParity)
		FROM dbo.Sow s
		WHERE RemovalType = 'TRANSFER'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_SowsAndGiltsTransferredBase] TO [se\analysts]
    AS [dbo];

