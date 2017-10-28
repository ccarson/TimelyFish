 create procedure DMG_PR_POReceipt_Fetch
	@CpnyID		varchar(10),
	@BatNbr		varchar(10)
as
	select	*
	from	POReceipt
	where	CpnyID = @CpnyID
	and	BatNbr = @BatNbr


