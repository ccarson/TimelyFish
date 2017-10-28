 create procedure DMG_PurchOrd_Fetch
	@CpnyID		varchar(10),
	@PONbr		varchar(10)
as
	select	*
	from	PurchOrd
	where	CpnyID = @CpnyID
	and	PONbr = @PONbr


