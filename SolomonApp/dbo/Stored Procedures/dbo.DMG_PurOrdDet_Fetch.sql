 create procedure DMG_PurOrdDet_Fetch
	@PONbr		varchar(10)
as
	select	*
	from	PurOrdDet
	where	PONbr = @PONbr and PONbr <> ''


