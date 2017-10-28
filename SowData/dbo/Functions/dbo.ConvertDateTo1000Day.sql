CREATE FUNCTION dbo.ConvertDateTo1000Day (@InputDate smalldatetime)
	RETURNS varchar(6)
	AS
	BEGIN
	DECLARE @DayCnt int
    	DECLARE @CycleStr varchar(2)
	DECLARE @DayStr varchar(3)
	DECLARE @First1000DayDate smalldatetime
	DECLARE @ConvertDateTo1000Day varchar(6)
	SELECT @First1000DayDate = '9/27/1971'
	SELECT @DayCnt = datediff(day,@First1000DayDate,@InputDate)
	SELECT @CycleStr = RTrim(LTrim(Str(Convert(varchar(3),@DayCnt / 1000))))
    	SELECT @DayStr = Right('000' + LTrim(Str(@DayCnt % 1000)),3)
	SELECT @ConvertDateTo1000Day = @CycleStr + '-' + @DayStr
	RETURN @ConvertDateTo1000Day
	END
