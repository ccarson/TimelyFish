CREATE VIEW [vPM2_EndingFemaleInventoryBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	AS
 SELECT s.FarmID, s.SowID, wd.WeekOfDate, s.Genetics, 
	SowParity = (SELECT Max(Parity) FROM SowParityTemp Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= wd.WeekEndDate)
	FROM WeekDefinitionTemp wd WITH (NOLOCK)
	JOIN SowTemp s WITH (NOLOCK) ON s.EntryDate <= wd.WeekEndDate AND ISNULL(s.RemovalDate,'1/1/2059') > wd.WeekEndDate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_EndingFemaleInventoryBase] TO [se\analysts]
    AS [dbo];

