 create proc DMG_UpdateAll_Get_PO_IS
	@InvtIDParm	varchar (30),
	@SiteIDParm	varchar (10)
as
	select		h.CpnyID, h.PONbr
	from		Purchord h
	where		h.Status in ('O', 'P')
		and exists (
			SELECT *
			FROM PurOrdDet d
			WHERE		d.PONbr = h.PONbr
				and	d.InvtID like @InvtIDParm
				and	d.SiteID like @SiteIDParm )
	order by	PONbr


