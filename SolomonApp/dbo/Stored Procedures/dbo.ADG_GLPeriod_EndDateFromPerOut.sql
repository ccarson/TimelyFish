 create procedure ADG_GLPeriod_EndDateFromPerOut
	@Period			varchar (6),
	@PerEnd			varchar (4) output
as
	declare @PeriodStr	varchar(2)

	-- Retrieve the period number from the Period variable
	select @PeriodStr = right(@Period, 2)

	if @PeriodStr = '01'
		select @PerEnd = FiscalPerEnd00 from GLSetup (nolock)
	if @PeriodStr = '02'
		select @PerEnd = FiscalPerEnd01 from GLSetup (nolock)
	if @PeriodStr = '03'
		select @PerEnd = FiscalPerEnd02 from GLSetup (nolock)
	if @PeriodStr = '04'
		select @PerEnd = FiscalPerEnd03 from GLSetup (nolock)
	if @PeriodStr = '05'
		select @PerEnd = FiscalPerEnd04 from GLSetup (nolock)
	if @PeriodStr = '06'
		select @PerEnd = FiscalPerEnd05 from GLSetup (nolock)
	if @PeriodStr = '07'
		select @PerEnd = FiscalPerEnd06 from GLSetup (nolock)
	if @PeriodStr = '08'
		select @PerEnd = FiscalPerEnd07 from GLSetup (nolock)
	if @PeriodStr = '09'
		select @PerEnd = FiscalPerEnd08 from GLSetup (nolock)
	if @PeriodStr = '10'
		select @PerEnd = FiscalPerEnd09 from GLSetup (nolock)
	if @PeriodStr = '11'
		select @PerEnd = FiscalPerEnd10 from GLSetup (nolock)
	if @PeriodStr = '12'
		select @PerEnd = FiscalPerEnd11 from GLSetup (nolock)
	if @PeriodStr = '13'
		select @PerEnd = FiscalPerEnd12 from GLSetup (nolock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_GLPeriod_EndDateFromPerOut] TO [MSDSL]
    AS [dbo];

