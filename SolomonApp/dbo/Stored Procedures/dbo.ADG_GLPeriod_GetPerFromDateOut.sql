 create procedure ADG_GLPeriod_GetPerFromDateOut
	@Date			datetime,
	@UseCurrentOMPeriod	smallint,
	@Period			varchar(6) output
as
	declare	@BegFiscalYr	smallint,	-- Fiscal year begin/end in calendar year setting.
		@NbrPer		smallint,	-- Number of periods in the fiscal year.
		@NbrPerIdx	smallint,	-- Index for iterating through the fiscal periods.

		@DateYMD	char(8),	-- Year/month/day of the calendar date passed in.
		@DateYear	char(4),	-- Year of calendar date passed in.
		@DateMD		char(4),	-- Month/day of the calendar date passed in.
		@DatePer	smallint,	-- Period number in which the passed in calendar date falls.

		@FirstPerEndMD	char(4),	-- Month/day of the first fiscal period end.
		@FirstPerYear	smallint,	-- Calendar year of the first fiscal period.
		@LastPerEndMD	char(4),	-- Month/day of the last fiscal period end.
		@LastPerYear	smallint,	-- Calendar year of the last fiscal period.
		@PerEndMD	char(4),	-- Month/day of the fiscal period end.
		@PerEndMDArray	char(52),	-- String array of fiscal period end year/month/days. 13 * 4: 13 possible periods.
		@PerYear	smallint,	-- Calendar year of the fiscal period in the current loop iteration.
		@PrevPerEndMD	char(4)		-- Month/day of the fiscal period end in the previous loop iteration.

	-----------------------------------------------------------
	-- Check the 'Post Invoices to Current OM Period' setting. Note
	-- that not all cases use the current OM period setting, so the
	-- @UseCurrentOMPeriod flag will be passed in accordingly.
	-----------------------------------------------------------
	if (@UseCurrentOMPeriod = 1) and ((select substring(S4Future01, 1, 1) from SOSetup (nolock)) = '1')
	begin
		select	@Period =	case when INSetup.CurrPerNbr > ARSetup.CurrPerNbr then
						INSetup.CurrPerNbr
					else
						ARSetup.CurrPerNbr
					end
		from	ARSetup (nolock)
		left join INSetup (nolock)
		on	INSetup.[Init] = 1

		return(0)
	end

	-- Get the year/month/day, month/day, and year formats of the date passed in.
	set	@DateYMD =	cast(datepart(year, @Date) as char(4)) +
				right('0' + cast(datepart(month, @Date) as varchar(2)), 2) +
				right('0' + cast(datepart(day, @Date) as varchar(2)), 2)
	set	@DateYear =	left(@DateYMD, 4)
	set	@DateMD =	right(@DateYMD, 4)

	-- Get the fiscal year beginning setting, the number of periods, and a string
	-- containing all of the period end dates.
	select	@BegFiscalYr = BegFiscalYr,	-- 1: FY begins in CY; 0: FY ends in CY
		@NbrPer = NbrPer,
		@PerEndMDArray =	FiscalPerEnd00 + FiscalPerEnd01 + FiscalPerEnd02 + FiscalPerEnd03 +
					FiscalPerEnd04 + FiscalPerEnd05 + FiscalPerEnd06 + FiscalPerEnd07 +
					FiscalPerEnd08 + FiscalPerEnd09 + FiscalPerEnd10 + FiscalPerEnd11 +
					FiscalPerEnd12
	from	GLSetup (nolock)

	-- Get the month/day for the first and last fiscal periods. This allows us to
	-- determine the calendar year for the first and last fiscal periods. Assumes
	-- leap year for February end dates since only string comparisons are used.
	set	@FirstPerEndMD = substring(@PerEndMDArray, 1, 4)
	if (@FirstPerEndMD = '0228')
		set	@FirstPerEndMD = '0229'

	set	@LastPerEndMD = substring(@PerEndMDArray, ((@NbrPer - 1) * 4) + 1, 4)
	if (@LastPerEndMD = '0228')
		set	@LastPerEndMD = '0229'

	set	@FirstPerYear =	case when @DateMD > @LastPerEndMD then
					datepart(year, @Date)
				else
					-- Only subtract if the FY spans CYs because otherwise the FY and CY
					-- are aligned. This isn't as clean as the @LastPerYear calculation
					-- because we do not have the the *first* day of the first period.
					case when @FirstPerEndMD > @LastPerEndMD then
						datepart(year, @Date) - 1
					else
						datepart(year, @Date)
					end
				end

	set	@LastPerYear =	case when @DateMD <= @LastPerEndMD then
					datepart(year, @Date)
				else
					datepart(year, @Date) + 1
				end

	-- Initialization prior to iterating through period end month/days.
	set	@DatePer = 0
	set	@NbrPerIdx = @NbrPer - 1
	set	@PerYear = @LastPerYear
	set	@PrevPerEndMD = ''

	-- Loop backward through the period array to (1) adjust any February end dates for possible leap
	-- year problems and (2) determine the period in which the date falls.
	while	@NbrPerIdx >= 0
	begin
		-- Get the period end month/day for the current iteration.
		set	@PerEndMD = substring(@PerEndMDArray, (@NbrPerIdx * 4) + 1, 4)

		-- Adjust period end date for February end dates. Since only string compares are used,
		-- it's more efficient just to always use 2/29 rather than determine if it is leap year.
		if (@PerEndMD = '0228')
			set	@PerEndMD = '0229'

		-- Determine the year of the period end month/day.
		if (@PrevPerEndMD < @PerEndMD) and (@PrevPerEndMD <> '')
			set	@PerYear = @PerYear - 1

		-- Determine if the date passed in belongs in this period. Since the loop iterates
		-- backwards through the end dates, if the passed in date is greater than the current
		-- period end date, then we've passed the period in which the date falls, so it must
		-- be in the 'prior' period. The final test catches the case for dates falling in the
		-- first fiscal period.
		if (@DateYMD > (cast(@PerYear as char(4)) + @PerEndMD))
			-- The period loop index is already the current period minus one, so we
			-- must add two to get to the 'previous' period number in the loop.
			set	@DatePer = @NbrPerIdx + 2
		else if (@NbrPerIdx = 0)
			-- If we've exhausted the period list, then the date is in the 'current'
			-- (first) period.
			set	@DatePer = @NbrPerIdx + 1

		-- Check if the period was found.
		if (@DatePer = 0)
		begin
			-- Save the current period end month/day and check the next period.
			set	@PrevPerEndMD = @PerEndMD
			set	@NbrPerIdx = @NbrPerIdx - 1
		end
		else
			-- The period was found, so exit the loop.
			set	@NbrPerIdx = -1
	end	-- while

	-- Use the BegFiscalYr (1: FY begins in CY; 0: FY ends in CY) setting to determine if
	-- the the year will be the first period year or the last period year.
	if (@BegFiscalYr = 0)
		set	@Period = cast(@LastPerYear as char(4)) + right('0' + cast(@DatePer as varchar(2)), 2)
	else
		set	@Period = cast(@FirstPerYear as char(4)) + right('0' + cast(@DatePer as varchar(2)), 2)


