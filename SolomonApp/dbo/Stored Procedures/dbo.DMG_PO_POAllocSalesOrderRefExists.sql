 create procedure DMG_PO_POAllocSalesOrderRefExists
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15),
	@SOLineRef	varchar(5),
	@SOSchedRef	varchar(5),
	@PONbr		varchar(10)
AS
		if (
	select	count(*)
	from	POAlloc (NOLOCK)
	where	CpnyID = @CpnyID
	and	SOOrdNbr = @SOOrdNbr
	and	SOLineRef = @SOLineRef
	and	SOSchedRef = @SOSchedRef
	and	PONbr <> @PONbr
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_POAllocSalesOrderRefExists] TO [MSDSL]
    AS [dbo];

