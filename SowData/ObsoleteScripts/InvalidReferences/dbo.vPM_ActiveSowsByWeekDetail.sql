CREATE VIEW [dbo].[vPM_ActiveSowsByWeekDetail] (FarmID, EntryDate, RemovalDate, WeekOfDate, WeekEndDate, SowID, LastGroupDate, SowParity, SowGenetics)
	As
 SELECT s.FarmID, s.EntryDate, s.RemovalDate, wd.WeekOfDate, wd.WeekEndDate, s.SowId, sge.EventDate, sge.SowParity, s.Genetics
	FROM dbo.WeekDefinitionTemp wd
	JOIN dbo.Sow s ON s.EntryDate < wd.WeekEndDate
		AND IsNull(s.RemovalDate,'12/31/2059') > wd.WeekEndDate
	JOIN SowGroupEvent sge on s.FarmID = sge.FarmID and s.SowID = sge.SowID
		AND EventDate = (Select Max(EventDate) from SowGroupEvent Where
			FarmID = s.FarmID and SowID = s.SowID and EventDate <= wd.WeekEndDate)
	WHERE s.SowID NOT IN(Select SowID from SowFarrowEvent Where FarmId = s.FarmID and SowID = s.SowID
		AND SowParity = sge.SowParity + 1 and EventDate <= wd.WeekEndDate AND EventDate > sge.EventDate)
	AND s.SowID NOT IN(Select SowID from SowFalloutEvent Where FarmId = s.FarmID and SowID = s.SowID
		AND SowParity = sge.SowParity and EventDate <= wd.WeekEndDate AND EventDate > sge.EventDate)
	AND s.SowID NOT IN(Select SowID from SowPregExamEvent Where FarmId = s.FarmID and SowID = s.SowID
		AND SowParity = sge.SowParity and EventDate <= wd.WeekEndDate AND EventDate > sge.EventDate and ExamResult = 'NEGATIVE')

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM_ActiveSowsByWeekDetail] TO [se\analysts]
    AS [dbo];

