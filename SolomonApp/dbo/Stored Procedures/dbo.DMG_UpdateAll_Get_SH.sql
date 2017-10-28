 create proc DMG_UpdateAll_Get_SH
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

	where		h.Status = 'O' or			-- Open shippers
			-- Or if closed, but transfer type with open transfer doc
			(t.behavior = 'TR' and (td.Status is null and h.INBatNbr = '' or td.Status <> 'R'))
	order by	h.CpnyID, h.ShipperID


