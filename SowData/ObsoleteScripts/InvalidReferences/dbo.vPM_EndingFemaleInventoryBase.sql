CREATE VIEW [dbo].[vPM_EndingFemaleInventoryBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	AS
 SELECT s.FarmID, s.SowID, wd.WeekOfDate, s.Genetics, 
	SowParity = (SELECT Max(Parity) FROM dbo.SowParity Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= wd.WeekEndDate)
	FROM dbo.WeekDefinition wd
	JOIN dbo.Sow s ON s.EntryDate <= wd.WeekEndDate AND ISNULL(s.RemovalDate,'1/1/2059') > wd.WeekEndDate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_EndingFemaleInventoryBase] TO [se\analysts]
    AS [dbo];

