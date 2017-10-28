 create proc ADG_CreateShipper_InvcNbrCount
	@CpnyID		varchar(10),
	@InvcNbr	varchar(15)
as
	select	count(*)
	from	SOShipHeader

	where	CpnyID = @CpnyID
	  and	InvcNbr = @InvcNbr
	  and	Cancelled = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CreateShipper_InvcNbrCount] TO [MSDSL]
    AS [dbo];

