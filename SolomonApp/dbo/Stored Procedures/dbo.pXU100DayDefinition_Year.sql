CREATE PROC pXU100DayDefinition_Year
	@Year smallint,
	@BegDate smalldatetime,
	@EndDate smalldatetime
	AS
	SELECT dd.* 
	FROM cftDayDefinition dd
	JOIN cftWeekDefinition wd ON dd.WeekOfDate = wd.WeekOfDate
	WHERE wd.PICYear = @Year
	AND DayDate BETWEEN @BegDate AND @EndDate
	ORDER BY DayDate

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU100DayDefinition_Year] TO [MSDSL]
    AS [dbo];

