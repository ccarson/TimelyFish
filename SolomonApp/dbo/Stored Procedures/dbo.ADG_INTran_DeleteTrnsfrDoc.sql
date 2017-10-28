 create proc ADG_INTran_DeleteTrnsfrDoc
	@CpnyID		varchar(10),
	@TrnsfrDocNbr	varchar(10),
	@BatNbr		varchar(10),
	@LastDocNbr	varchar(10)
as
	delete	TrnsfrDoc
	where	CpnyID = @CpnyID
	  and	TrnsfrDocNbr = @TrnsfrDocNbr
	  and	BatNbr = @BatNbr

	if @@rowcount = 1
	update	INSetup
	set	LstTrnsfrDocNbr = @LastDocNbr
	where	LstTrnsfrDocNbr = @TrnsfrDocNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_DeleteTrnsfrDoc] TO [MSDSL]
    AS [dbo];

