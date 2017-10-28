CREATE procedure [dbo].[pBuildWeekDefinitionTemp_remove]
	@YearStart smallint, @WeekStart smallint, @YearEnd smallint, @WeekEnd smallint
	AS
	-- Clear the week definition temp table and the day definition temp table
	TRUNCATE TABLE WeekDefinitionTemp
	TRUNCATE TABLE DayDefinitionTemp
	
	-- Load the weeks into weekdefinitiontemp
	INSERT INTO WeekDefinitionTemp
	SELECT weekofdate, weekenddate, picyear, picweek, fiscalyear, fiscalperiod FROM [$(SolomonApp)].dbo.cftWeekDefinition 
	WHERE WeekOfDate 
		Between (Select WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition WHERE PICYear = @YearStart
				AND PICWeek = @WeekStart)
			AND
			(Select WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition WHERE PICYear = @YearEnd
				AND PICWeek = @WeekEnd)
	
	-- Load DayDefinitionTemp using weekdefinitiontemp as a join to limit
	-- day range
	INSERT INTO DayDefinitionTemp
	SELECT dd.weekofdate,cfw.weekenddate ,dd.daydate, dd.dayname 
	FROM [$(SolomonApp)].dbo.cftDayDefinition dd
	JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate
	join [SolomonApp].[dbo].[cftWeekDefinition] cfw on cfw.WeekOfDate = wd.WeekOfDate

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildWeekDefinitionTemp_remove] TO [db_sp_exec]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pBuildWeekDefinitionTemp_remove] TO [se\analysts]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[pBuildWeekDefinitionTemp_remove] TO [se\analysts]
    AS [dbo];

