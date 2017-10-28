 create procedure DMG_POAlloc_Fetch
	@CpnyID		varchar(10),
	@PONbr		varchar(10)
as
	select	*
	from	POAlloc
	where	CpnyID = @CpnyID
	and	PONbr = @PONbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POAlloc_Fetch] TO [MSDSL]
    AS [dbo];

