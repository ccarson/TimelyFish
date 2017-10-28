
CREATE  View cfvIndStageSchedule (PigGroupID, Stage) as
    Select i.PigGroupID, i.Stage
	from PigData.dbo.IndStageSchedule i

