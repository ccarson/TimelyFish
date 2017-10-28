 create procedure DMG_PR_PurOrdDet_Fetch
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@LineRef	varchar(5)
as
	select	*
	from	PurOrdDet (NOLOCK)
        where 	PONbr = @PONbr
	and	LineRef like @LineRef
        and	PurchaseType in ('DL','FR','GI','GP','GS','MI','GN','PI','PS')
	order by LineNbr


