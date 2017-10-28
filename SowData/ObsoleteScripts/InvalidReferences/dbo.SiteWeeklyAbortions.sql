
CREATE VIEW [dbo].[SiteWeeklyAbortions]
	As
select FarmId, WeekOfDate, TotalAbortions = count(*) 
	from sowfalloutevent where eventtype = 'ABORTION'
	group by FarmId, weekofdate

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[SiteWeeklyAbortions] TO [se\analysts]
    AS [dbo];

