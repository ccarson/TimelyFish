 create procedure ADG_GLPeriod_GetEndDateAndYear
	@Period			varchar (6)
as
	declare @PerEnd		varchar (4)
	declare @BegFiscalYear	smallint
	declare @FirstPerEnd	varchar (4)
	declare @LastPerEnd	varchar (4)
	declare @PeriodYear	smallint
	declare @BegPerYear	smallint
	declare @EndPerYear	smallint
	declare @NbrPer		smallint
	declare @EndDateAndYear	smalldatetime
	declare @PeriodMonthStr	varchar (2)
	declare @PeriodDayStr	varchar (2)
	declare @PeriodYearStr	varchar (2)

	-- Get the PerEnd value for the given Period.
	execute ADG_GLPeriod_EndDateFromPerOut @Period, @PerEnd output

	-- Make sure that the @PerEnd value has a leading zero if only 3 digits.
	if datalength(@PerEnd) = 3
		select @PerEnd = '0' + @PerEnd

	-- Get the BegFiscalYear and FiscalPerEnd00 values from the GLSetup table.
	-- If the BegFiscalYear value is 1, then use the year of the beginning period.
	-- If the BegFiscalYear value is 0, then use the year of the end period.
	select	@BegFiscalYear = BegFiscalYr,
		@FirstPerEnd = FiscalPerEnd00,
		@NbrPer = NbrPer
	from 	GLSetup (nolock)

	-- Get the PerEnd for the last period.
	if @NbrPer = 1
		select @LastPerEnd = FiscalPerEnd00 from GLSetup (nolock)
	if @NbrPer = 2
		select @LastPerEnd = FiscalPerEnd01 from GLSetup (nolock)
	if @NbrPer = 3
		select @LastPerEnd = FiscalPerEnd02 from GLSetup (nolock)
	if @NbrPer = 4
		select @LastPerEnd = FiscalPerEnd03 from GLSetup (nolock)
	if @NbrPer = 5
		select @LastPerEnd = FiscalPerEnd04 from GLSetup (nolock)
	if @NbrPer = 6
		select @LastPerEnd = FiscalPerEnd05 from GLSetup (nolock)
	if @NbrPer = 7
		select @LastPerEnd = FiscalPerEnd06 from GLSetup (nolock)
	if @NbrPer = 8
		select @LastPerEnd = FiscalPerEnd07 from GLSetup (nolock)
	if @NbrPer = 9
		select @LastPerEnd = FiscalPerEnd08 from GLSetup (nolock)
	if @NbrPer = 10
		select @LastPerEnd = FiscalPerEnd09 from GLSetup (nolock)
	if @NbrPer = 11
		select @LastPerEnd = FiscalPerEnd10 from GLSetup (nolock)
	if @NbrPer = 12
		select @LastPerEnd = FiscalPerEnd11 from GLSetup (nolock)
	if @NbrPer = 13
		select @LastPerEnd = FiscalPerEnd12 from GLSetup (nolock)

	-- Get the Year from the period passed.
	select @PeriodYear = convert(smallint, substring(@Period, 1, 4))

	-- Get the correct year of the current period by checking the BegFiscalYear value.
	if @BegFiscalYear = 1
	begin
		if convert(smallint, @PerEnd) < convert(smallint, @FirstPerEnd)
			select @PeriodYear = @PeriodYear + 1
	end
	else
	begin
		if convert(smallint, @PerEnd) > convert(smallint, @LastPerEnd)
			select @PeriodYear = @PeriodYear - 1
	end

	-- Get the day of the period passed.
	select @PeriodDayStr = right(@PerEnd, 2)

	-- Get the month of the period passed
	select @PeriodMonthStr = substring(@PerEnd, 1, 2)

	-- Get the EndDateAndYear
	select @EndDateAndYear = @PeriodMonthStr + '/' + @PeriodDayStr + '/' + convert(varchar(4), @PeriodYear)

	select @EndDateAndYear


