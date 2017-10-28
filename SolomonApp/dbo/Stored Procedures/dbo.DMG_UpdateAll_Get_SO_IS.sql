 create proc DMG_UpdateAll_Get_SO_IS
	@InvtIDParm	varchar (30),
	@SiteIDParm	varchar (10)
as
	select		h.CpnyID, h.OrdNbr
	from		SOHeader h join	SOType	 t
				on 		h.CpnyID = t.CpnyID
					and	h.SOTypeID = t.SOTypeID
	where		h.Status = 'O'
			and
			(	exists (
					select *
					from SOLine l join SOSched s on l.CpnyID = s.CpnyID and l.OrdNbr = s.OrdNbr
					where l.CpnyID = h.CpnyID and l.OrdNbr = h.OrdNbr
						and l.InvtID like @InvtIDParm
						and s.SiteID like @SiteIDParm )

				or (		t.Behavior = 'WO'
					and	h.CancelDate > CONVERT (SMALLDATETIME, CONVERT (VARCHAR(8),GETDATE(),112),112)
					and h.BuildInvtID like @InvtIDParm
					and h.BuildSiteID like @SiteIDParm)) -- condition needed to process KA orders in ADGPlan::UpdateSO

	order by	h.CpnyID, h.OrdNbr


