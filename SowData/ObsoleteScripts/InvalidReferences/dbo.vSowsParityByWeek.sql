CREATE VIEW dbo.vSowsParityByWeek
	As 
	SELECT s.*, 
		SowParity = IsNull((SELECT Max(Parity) from SowParity Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= wd.WeekEndDate),s.InitialParity),  
		wd.*
		FROM WeekDefinition wd, Sow s
		WHERE s.EntryDate <= wd.WeekEndDate AND (RemovalDate IS NULL Or RemovalDate > wd.WeekEndDate)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowsParityByWeek] TO [se\analysts]
    AS [dbo];

