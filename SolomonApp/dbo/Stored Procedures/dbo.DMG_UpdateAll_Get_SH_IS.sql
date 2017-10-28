 create proc DMG_UpdateAll_Get_SH_IS
	@InvtIDParm	varchar (30),
	@SiteIDParm	varchar (10)
as
	select	h.CpnyID, h.ShipperID
	from	SOShipHeader h

	  join	SOType	t
	  on	t.CpnyID = h.CpnyID
	  and	t.SOTypeID = h.SOTypeID

	  left
	  join	TrnsfrDoc  td
	  on	td.CpnyID = h.CpnyID
	  and	td.BatNbr = h.INBatNbr

	where		(h.Status = 'O' or			-- Open shippers
			-- Or if closed, but transfer type with open transfer doc
			(t.behavior = 'TR' and (td.Status is null and h.INBatNbr = '' or td.Status <> 'R')))
			-- InvtID / SiteID filtering for integrity check
			and (	     exists (select * from SOShipLine l where l.CpnyID = h.CpnyID and l.ShipperID = h.ShipperID and l.InvtID like @InvtIDParm and l.SiteID like @SiteIDParm)
	 			or  (exists (select * from SOShipLine l where l.CpnyID = h.CpnyID and l.ShipperID = h.ShipperID and l.InvtID like @InvtIDParm) and h.ShipSiteID like @SiteIDParm) -- to let processing of Transfer Out lines
				or  (t.Behavior = 'WO' and exists (select * from SOHeader soh where soh.CpnyID = h.CpnyID and soh.OrdNbr = h.OrdNbr and soh.BuildInvtID like @InvtIDParm and soh.BuildSiteID like @SiteIDParm)) -- to let processing of the Kits from sales orders
				or  (t.Behavior = 'WO' and h.OrdNbr = '' and h.BuildInvtID like @InvtIDParm and h.SiteID like @SiteIDParm)) -- to let processing Kits from shippers

	order by	h.CpnyID, h.ShipperID


