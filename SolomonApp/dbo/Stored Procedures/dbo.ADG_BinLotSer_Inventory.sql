 create proc ADG_BinLotSer_Inventory
	@InvtID		varchar(30)
as
	select	LotSerIssMthd,
		LotSerTrack,
		SerAssign

	from	Inventory (nolock)
        where	InvtID = @InvtID


