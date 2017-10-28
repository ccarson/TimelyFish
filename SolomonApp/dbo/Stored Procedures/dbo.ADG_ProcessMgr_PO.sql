 create proc ADG_ProcessMgr_PO
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@LineRef	varchar(5)

as
	select	InvtID,
		SiteID

	from	PurOrdDet

	where	PONbr = @PONbr
	and	LineRef like @LineRef
--	and	CpnyID = @CpnyID
	group by
		InvtID,
		SiteID


