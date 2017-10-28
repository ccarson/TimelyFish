 create proc ADG_Plan_DropShipPO
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	select	a.PONbr,
		a.POLineRef,
		a.AllocRef

	from	POAlloc a

	where	a.CpnyID = @CpnyID
	and	a.SOOrdNbr = @OrdNbr
	and	a.SOLineRef = @LineRef
	and	a.SOSchedRef = @SchedRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_DropShipPO] TO [MSDSL]
    AS [dbo];

