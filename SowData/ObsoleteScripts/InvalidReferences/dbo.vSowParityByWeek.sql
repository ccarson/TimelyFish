CREATE VIEW [dbo].[vSowParityByWeek]
	As 
	SELECT s.*, 
		SowParity = IsNull((SELECT Max(Parity) FROM dbo.SowParity Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= wd.WeekEndDate),s.InitialParity),  
		wd.*
		FROM dbo.WeekDefinition wd, Sow s
		WHERE s.EntryDate <= wd.WeekEndDate AND (RemovalDate IS NULL Or RemovalDate > wd.WeekEndDate)

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowParityByWeek] TO [se\analysts]
    AS [dbo];

