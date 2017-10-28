 create proc ADG_CreateShipper_SOLotQtyAlloc
	@CpnyID		varchar(10),
	@OrdNbr		varchar(10),
	@LineRef	varchar(10),
	@SchedRef	varchar(10)
as
	select	*
	from	SOLot
	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr
	and	LineRef = @LineRef
	and	SchedRef = @SchedRef
	and	Status = 'O'
	order by LotSerRef


