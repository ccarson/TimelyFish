 create procedure DMG_PR_POAlloc_Fetch
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@POLineRef	varchar(5)
as
	select	*
	from	POAlloc (NOLOCK)
        where	CpnyID = @CpnyID
	and 	PONbr = @PONbr
	and	POLineRef = @POLineRef
	order by POLineRef


