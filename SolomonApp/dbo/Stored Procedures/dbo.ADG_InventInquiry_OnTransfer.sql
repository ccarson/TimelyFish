 create proc ADG_InventInquiry_OnTransfer
	@CpnyID 	VARCHAR(10),
	@InvtID		VARCHAR(30)
as
	SELECT
		case
			when p.PlanType = '29' then sl.AlternateID
			else l.AlternateID
			end,
		case
			when p.PlanType = '29' then sl.Cost
			else l.Cost
			end,
		p.CpnyID,
		case
			when p.PlanType = '29' then sh.CustID
			else h.CustID
			end,
		case
			when p.PlanType = '29' then sl.Descr
			else l.Descr
			end,
		p.InvtID,
		case
			when p.PlanType = '29' then sh.OrdDate
			else h.OrdDate
			end,
		p.SOOrdNbr,
		p.PlanDate,
		p.Qty,
		p.SOShipperID,
		'ShipToName' =	case
				when p.PlanType = '29' then
					case
					WHEN sh.ShiptoType = 'C' THEN sa.Name
					WHEN sh.ShiptoType = 'V' THEN sv.Name
					WHEN sh.ShiptoType = 'S' THEN CAST(si.Name AS CHAR(60))
					WHEN sh.ShiptoType = 'O' THEN sd.Name
					ELSE sh.ShipName
					END
				else
					case
					WHEN s.ShiptoType = 'C' THEN a.Name
					WHEN s.ShiptoType = 'V' THEN v.Name
					WHEN s.ShiptoType = 'S' THEN CAST(i.Name AS CHAR(60))
					WHEN s.ShiptoType = 'O' THEN d.Name
					ELSE h.ShipName
					END
				end,
		p.SiteID,
		case
			when p.PlanType = '29' then sl.SlsPrice
			else l.SlsPrice
			end,
		p.SOReqDate,
		case
			when p.PlanType = '29' then sl.UnitDesc
			else l.UnitDesc
			end

	FROM	SOPlan p
		LEFT JOIN SOHeader h	ON p.CpnyID = h.CpnyID AND p.SOOrdNbr = h.OrdNbr
		LEFT JOIN SOLine l 	ON p.CpnyID = l.CpnyID AND p.SOOrdNbr = l.OrdNbr AND p.SOLineRef = l.LineRef
		LEFT JOIN SOSched s	ON p.CpnyID = s.CpnyID AND p.SOOrdNbr = s.OrdNbr AND p.SOLineRef = s.LineRef AND p.SOSchedRef = s.SchedRef
		LEFT JOIN SOShipHeader sh ON p.CpnyID = sh.CpnyID and p.SOShipperID = sh.ShipperID
		LEFT JOIN SOShipLine sl	ON p.CpnyID = sl.CpnyID and p.SOShipperID = sl.ShipperID and p.SOShipperLineRef = sl.LineRef
		LEFT JOIN SOAddress a	ON s.ShipCustID = a.CustID AND s.ShipToID = a.ShipToID
		LEFT JOIN Vendor v	ON s.ShipVendID = v.VendID
		LEFT JOIN Site i	ON s.ShipSiteID = i.SiteID
		LEFT JOIN Address d	ON s.ShipAddrID = d.AddrID
		LEFT JOIN SOAddress sa	ON sh.ShipCustID = sa.CustID AND sh.ShipToID = sa.ShipToID
		LEFT JOIN Vendor sv	ON sh.ShipVendID = sv.VendID
		LEFT JOIN Site si	ON sh.ShipSiteID = si.SiteID
		LEFT JOIN Address sd	ON sh.ShipAddrID = sd.AddrID

	WHERE	p.CpnyID LIKE @CpnyID
	  AND	p.InvtID = @InvtID
	  AND	p.PlanType in ('28', '29')
	ORDER BY
		p.DisplaySeq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventInquiry_OnTransfer] TO [MSDSL]
    AS [dbo];

