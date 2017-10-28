
CREATE PROC checkModulePeriod @Module VARCHAR(2), @yearPeriod INT, @show_select int
AS
	DECLARE @return_value INT

	SELECT @return_value = COUNT(*) 
	FROM Batch
	WHERE STATUS IN ('B', 'H')
		AND Module LIKE @Module
		AND PerPost < @yearPeriod
	IF @show_select = 1
		SELECT @return_value
	RETURN @return_value

GO
GRANT CONTROL
    ON OBJECT::[dbo].[checkModulePeriod] TO [MSDSL]
    AS [dbo];

