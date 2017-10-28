 create proc ADG_InventInquiry_Allocated
	@CpnyID 	varchar(10),
	@InvtID		varchar(30)
as

	select	l.*,
		'ShipToName' = Case
				When s.ShiptoType = 'C' Then a.Name
				When s.ShiptoType = 'V' Then v.Name
				When s.ShiptoType = 'S' Then CAST(i.Name AS CHAR(60))
				When s.ShiptoType = 'O' Then d.Name
				Else h.ShipName end,
		p.PlanDate, h.OrdDate, h.CustID,
		p.InvtID, p.SiteID, (p.Qty * -1), p.SOReqDate,
		p.SOShipperID, p.SOOrdNbr
	from	SOShipline l
	join 	SOShipHeader h on h.cpnyid = l.cpnyid and h.shipperid = l.shipperid
	join	soplan p on p.cpnyid = l.cpnyid and p.soshipperid = l.shipperid and p.invtid = l.invtid and p.siteID = h.SiteID and p.SOShipperLineRef = l.LineRef
		left join SOSched s on s.cpnyid = l.cpnyid and s.OrdNbr = l.OrdNbr and s.lineref = l.lineref
		left join SOAddress a on a.CustID = h.CustID and a.ShipToID = h.ShipToID
		left join Vendor v on v.VendId = h.ShipVendID
		left join Site i on i.Siteid = h.ShipSiteID
		left join Address d on d.AddrId = h.ShipAddrID
	where	l.cpnyid = @CpnyID
	  and	l.invtid = @InvtID
	  and	p.plantype in ('30', '32', '34')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventInquiry_Allocated] TO [MSDSL]
    AS [dbo];

