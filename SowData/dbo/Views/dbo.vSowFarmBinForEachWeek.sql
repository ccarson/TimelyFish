CREATE VIEW vSowFarmBinForEachWeek
	AS
	SELECT FarmID=dbo.GetSowFarmIDFromContactID(v.ContactID, wd.WeekOfDate), 
	v.*, wd.WeekOfDate, wd.WeekEndDate
	FROM vSowFarmBin v, WeekDefinition wd
	WHERE wd.WeekOfDate >= '12/26/04'  --PER RON THIS IS FIRST COMPLETE PERIOD OF DATA FOR ISO Days and this feed consumption

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowFarmBinForEachWeek] TO [se\analysts]
    AS [dbo];

