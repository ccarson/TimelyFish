
CREATE FUNCTION XDDGetOffSetDate
	(@StartDate 	smalldatetime,
	 @FormatID	varchar(15)
	)

	RETURNS smalldatetime
AS

BEGIN

	Declare @Return 	smalldatetime
	Declare @OffSetDays	int
	Declare @Done		bit
	Declare @CurrDayOfWeek	tinyint
	
	SET	@OffSetDays = 0
	
	-- Get OffSetDays for this format
	SELECT	@OffSetDays = EffDateOffSet
	FROM	XDDFileFormat (nolock)
	WHERE	FormatID = @FormatID

	-- Add OffSetDays to StartDate
	SET	@Return = DateAdd(day, @OffSetDays, @StartDate)
	
	-- Now check if this date is a weekend or holiday
	--	Keep incrementing until find good date
	While (1=1)
	BEGIN
		-- @Done = 0, means we are still on a weekend or holiday
		SET	@Done = 0
		SET	@CurrDayOfWeek = 0
	
		SET	@CurrDayOfWeek = datepart(dw, @Return)
		-- For now assume @@DateFirst = 7 (Sunday - US)
		-- May need to adjust if Europe = 1 (Monday)
		
		-- First Day of week is Sunday, then 1/7 are Sat/Sim
		if @CurrDayOfWeek <> 1 and @CurrDayOfWeek <> 7	SET @Done = 1

		-- If not Sat/Sun, then see if holiday
		if @Done = 1
			if exists(Select * from XDDBankHolidays (nolock) WHERE Holiday = @Return) SET @Done = 0
		
		if @Done = 1	BREAK
		
		SET	@Return = DateAdd(day, 1, @Return)
	END
	
	RETURN @return
END
