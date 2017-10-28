 create procedure DMG_PR_APDoc_Fetch
	@CpnyID		varchar(10),
	@BatNbr		varchar(10)
as
	select	*
	from	APDoc
	where	DocClass = 'N'
	and	CpnyID = @CpnyID
	and	RefNbr in	(	select	APRefNo from POReceipt (NOLOCK)
					where	CpnyID = @CpnyID
					and 	BatNbr = @BatNbr
				)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_APDoc_Fetch] TO [MSDSL]
    AS [dbo];

