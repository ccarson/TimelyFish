 create procedure DMG_GetTranCuryInfo
	@FromCuryID 	varchar(4),
	@ToCuryID	varchar(4),
	@RateType	varchar(6),
	@EffDate	smalldatetime,
	@CuryEffDate	smalldatetime OUTPUT,
	@CuryMultDiv	varchar(1) OUTPUT,
	@CuryRate	decimal(25,9) OUTPUT,
	@CuryRateType	varchar(6) OUTPUT,
	@DecPl		smallint OUTPUT
as
	select	top 1
		@CuryEffDate = EffDate,
		@CuryMultDiv = MultDiv,
		@CuryRate = Rate,
		@CuryRateType = RateType,
		@DecPl = DecPl
	from	CuryRate
	join	Currncy on CuryID = @FromCuryID
	where	FromCuryID = @FromCuryID
	and	ToCuryID = @ToCuryID
	and	RateType = @RateType
	and	DATEDIFF(day,EffDate,@EffDate) >= 0
	order by EffDate DESC

	if @@ROWCOUNT = 0 begin
		set @CuryEffDate = getdate()
		set @CuryMultDiv = 'M'
		set @CuryRate = 1
		set @CuryRateType = ''
		set @DecPl = 0
		return 0	--Failure
	end
	else
		--select @CuryEffDate, @CuryMultDiv, @CuryRate, @CuryRateType, @DecPl
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetTranCuryInfo] TO [MSDSL]
    AS [dbo];

