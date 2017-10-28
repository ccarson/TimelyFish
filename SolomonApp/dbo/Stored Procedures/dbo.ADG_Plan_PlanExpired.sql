 create proc ADG_Plan_PlanExpired
	@InvtID		varchar(30)
as
	declare	@PlanExpired	smallint	-- logical
	declare	@LotSerIssMthd	varchar(1)
	declare	@LotSerTrack	varchar(2)
	declare	@SerAssign	varchar(1)

	select	@LotSerIssMthd = LotSerIssMthd,
		@LotSerTrack = LotSerTrack,
		@SerAssign = SerAssign

	from	Inventory (nolock)
	where	InvtID = @InvtID

	select	@PlanExpired = 0

	if (@LotSerIssMthd = 'E')
		if (@LotSerTrack in ('LI', 'SI'))
			if (@SerAssign = 'R')
				select @PlanExpired = 1

	select @PlanExpired


