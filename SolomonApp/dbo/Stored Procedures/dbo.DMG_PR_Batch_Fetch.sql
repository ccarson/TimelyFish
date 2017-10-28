 create procedure DMG_PR_Batch_Fetch
	@CpnyID		varchar(10),
	@BatNbr		varchar(10)
as
	select	*
	from	Batch
	where	CpnyID = @CpnyID
	and	BatNbr = @BatNbr
	and	Module = 'PO'
	and	EditScrnNbr = '04010'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_Batch_Fetch] TO [MSDSL]
    AS [dbo];

