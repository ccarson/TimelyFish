 create proc ADG_InventInquiry_OnBackOrder
	@CpnyID 	VARCHAR(10),
	@InvtID		VARCHAR(30)
as
	SELECT
		l.AlternateID,
		l.Cost,
		p.CpnyID,
		h.CustID,
		l.Descr,
		p.InvtID,
		h.OrdDate,
		p.SOOrdNbr,
		p.PlanDate,
		-p.Qty,
		'ShipperID' = space(15),
		'ShipToName' = Case
				WHEN s.ShiptoType = 'C' THEN a.Name
				WHEN s.ShiptoType = 'V' THEN v.Name
				WHEN s.ShiptoType = 'S' THEN CAST(i.Name AS CHAR(60))
				WHEN s.ShiptoType = 'O' THEN d.Name
				ELSE h.ShipName END,
		p.SiteID,
		l.SlsPrice,
		p.SOReqDate,
		l.UnitDesc
	FROM	SOPlan p
		JOIN SOHeader h ON p.CpnyID = h.CpnyID AND p.SOOrdNbr = h.OrdNbr
		JOIN SOLine l 	ON p.CpnyID = l.CpnyID AND p.SOOrdNbr = l.OrdNbr AND p.SOLineRef = l.LineRef
		LEFT JOIN SOSched s	ON p.CpnyID = s.CpnyID AND p.SOOrdNbr = s.OrdNbr AND p.SOLineRef = s.LineRef AND p.SOSchedRef = s.SchedRef
		LEFT JOIN SOAddress a	ON s.ShipCustID = a.CustID AND s.ShipToID = a.ShipToID
		LEFT JOIN Vendor v	ON s.ShipVendID = v.VendID
		LEFT JOIN Site i	ON s.ShipSiteID = i.SiteID
		LEFT JOIN Address d	ON s.ShipAddrID = d.AddrID
	WHERE	p.CpnyID LIKE @CpnyID
	  AND	p.InvtID = @InvtID
	  AND	p.PlanType in ('50', '52', '54', '60', '62', '64')
	  AND 	p.PlanDate > p.SOReqShipDate
	ORDER BY
		p.DisplaySeq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventInquiry_OnBackOrder] TO [MSDSL]
    AS [dbo];

