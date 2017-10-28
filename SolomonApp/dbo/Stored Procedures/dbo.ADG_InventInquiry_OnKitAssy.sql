 create proc ADG_InventInquiry_OnKitAssy
	@CpnyID 	VARCHAR(10),
	@InvtID		VARCHAR(30)
as
	DECLARE	@AlternateID	VARCHAR(30)
	DECLARE @Cost		FLOAT
	DECLARE @ShipToName	VARCHAR(30)
	DECLARE @SlsPrice	FLOAT

	SELECT	@AlternateID = '', @Cost = 0, @ShipToName = '', @SlsPrice = 0

	SELECT	'AlternateID' = @AlternateID,
		'Cost' = @Cost,
		p.CpnyID,
		case
			when (p.PlanType = '26' and rtrim(p.SOOrdNbr) = '') then sh.CustID
			else h.CustID
			end,
		i.Descr,
		p.InvtID,
		case
			when (p.PlanType = '26' and rtrim(p.SOOrdNbr) = '') then sh.OrdDate
			else h.OrdDate
			end,
		p.SOOrdNbr,
		p.PlanDate,
		p.Qty,
		p.SOShipperID,
		'ShipToName' = @ShipToName,
		p.SiteID,
		'SlsPrice' = @SlsPrice,
		p.SOReqDate,
		i.StkUnit

	FROM	SOPlan  p
		LEFT JOIN SOHeader  h		ON p.CpnyID = h.CpnyID AND p.SOOrdNbr = h.OrdNbr
		LEFT JOIN SOShipHeader  sh	ON p.CpnyID = sh.CpnyID AND p.SOShipperID = sh.ShipperID
		JOIN Inventory  i		ON p.InvtID = i.InvtID

	WHERE	p.CpnyID LIKE @CpnyID
	  AND	p.InvtID = @InvtID
	  AND	p.PlanType in ('25', '26')

	ORDER BY
		p.DisplaySeq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventInquiry_OnKitAssy] TO [MSDSL]
    AS [dbo];

