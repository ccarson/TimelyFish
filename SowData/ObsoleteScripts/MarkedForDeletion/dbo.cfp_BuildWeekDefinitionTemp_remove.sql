create procedure [dbo].[cfp_BuildWeekDefinitionTemp_remove]

	AS
	-- Clear the week definition temp table and the day definition temp table
	TRUNCATE TABLE WeekDefinitionTemp
	TRUNCATE TABLE DayDefinitionTemp
	
	-- Load the weeks into weekdefinitiontemp
	INSERT INTO WeekDefinitionTemp
	SELECT weekofdate, weekenddate, picyear, picweek, fiscalyear, fiscalperiod FROM [$(SolomonApp)].dbo.cftWeekDefinition 
	WHERE WeekOfDate 
		Between (Select WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition WHERE PICYear = Year(CAST(  DATEADD(year,-2,getdate()) AS DATE))
				AND PICWeek = (select datepart(week,CAST(  DATEADD(year,-2,getdate()) AS DATE))) )
			AND
			(Select WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition WHERE PICYear = Year(getdate())
				AND PICWeek = (select datepart(week,CAST(getdate() AS DATE))) )
	
	-- Load DayDefinitionTemp using weekdefinitiontemp as a join to limit
	-- day range
	INSERT INTO DayDefinitionTemp
	SELECT dd.weekofdate,cfw.weekenddate ,dd.daydate, dd.dayname 
	FROM [$(SolomonApp)].dbo.cftDayDefinition dd
	JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate
	join [SolomonApp].[dbo].[cftWeekDefinition] cfw on cfw.WeekOfDate = wd.WeekOfDate

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_BuildWeekDefinitionTemp_remove] TO [db_sp_exec]
    AS [dbo];

