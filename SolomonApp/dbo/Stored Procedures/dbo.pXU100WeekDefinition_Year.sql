CREATE PROC pXU100WeekDefinition_Year
	@Year smallint,
	@WeekBeg smalldatetime,
	@WeekEnd smalldatetime
	AS
	
	SELECT * 
	FROM cftWeekDefinition
	WHERE PICYear = @Year
	AND WeekOfDate BETWEEN @WeekBeg AND @WeekEnd
	ORDER BY WeekOfDate

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU100WeekDefinition_Year] TO [MSDSL]
    AS [dbo];

