 create procedure DMG_SOTypeSelected
	@CpnyID			varchar(10),
	@SOTypeID		varchar(10),
	@Behavior		varchar(4) OUTPUT,
	@CancelDays		smallint OUTPUT,
	@Disp			varchar(3) OUTPUT,
	@EnterLotSer		smallint OUTPUT,
	@MiscAcct		varchar(10) OUTPUT,
	@MiscSub		varchar(31) OUTPUT,
	@RequireDetailAppr	smallint OUTPUT,
	@RequireManRelease	smallint OUTPUT,
	@RequireTechAppr	smallint OUTPUT,
	@ShiptoType		varchar(1) OUTPUT,
	@SlsAcct		varchar(10) OUTPUT
as
	select	@Behavior = ltrim(rtrim(Behavior)),
		@CancelDays = CancelDays,
		@Disp = ltrim(rtrim(Disp)),
		@EnterLotSer = EnterLotSer,
		@MiscAcct = ltrim(rtrim(MiscAcct)),
		@MiscSub = ltrim(rtrim(MiscSub)),
		@RequireDetailAppr = RequireDetailAppr,
		@RequireManRelease = RequireManRelease,
		@RequireTechAppr = RequireTechAppr,
		@ShiptoType = ltrim(rtrim(ShiptoType)),
		@SlsAcct = ltrim(rtrim(SlsAcct))
	from	SOType (NOLOCK)
	where	CpnyID = @CpnyID
	and	SOTypeID = @SOTypeID

	if @@ROWCOUNT = 0 begin
		set @Behavior = ''
		set @CancelDays = 0
		set @Disp = ''
		set @EnterLotSer = 0
		set @MiscAcct = ''
		set @MiscSub = ''
		set @RequireDetailAppr = 0
		set @RequireManRelease = 0
		set @RequireTechAppr = 0
		set @ShiptoType = ''
		set @SlsAcct = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOTypeSelected] TO [MSDSL]
    AS [dbo];

