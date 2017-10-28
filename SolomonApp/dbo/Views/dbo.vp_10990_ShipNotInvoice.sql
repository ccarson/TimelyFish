 

Create View vp_10990_ShipNotInvoice
As
--OM side
SELECT	d.InvtID, d.SiteID, l.WhseLoc, l.LotSerNbr, l.S4Future01 AS SpecificCostID, l.QtyShip AS QtyShipNotInv, h.CpnyID
FROM 		SOShipHeader h 
		JOIN SOShipLine d ON	h.CpnyID = d.CpnyID
		AND 	h.ShipperID = d.ShipperID
    		 			JOIN SOShipLot l ON 	d.CpnyID = l.CpnyID
     							AND 	d.ShipperID = l.ShipperID
     							AND 	d.LineRef = l.LineRef
     					JOIN Inventory i ON 	d.InvtID = i.InvtID
			WHERE 		h.Status = 'C' AND h.Cancelled = 0
  					AND h.DropShip = 0
  					AND l.QtyShip > 0
  					AND i.StkItem = 1
  					AND h.SOTypeID IN (SELECT SOTypeID FROM SOType 
                                      			WHERE h.CpnyID = CpnyID AND Behavior NOT IN ('CM', 'DM', 'SHIP'))
					AND h.ShipRegisterID = ''
					AND h.INBatNbr = ''
					AND h.ARBatNbr = ''

UNION

--IN Side	Non-Lot/Serial Items
SELECT	N.InvtID, N.SiteID, N.WhseLoc, '' AS LotSerNbr, N.SpecificCostID, 
	Case 	When N.CnvFact = 0
			Then (N.Qty * N.InvtMult * -1)
		Else
			Case 	When N.UnitMultDiv = 'D'
					Then (N.Qty * N.InvtMult * -1) / N.CnvFact
				Else (N.Qty * N.InvtMult * -1) * N.CnvFact	-- UnitMultDiv = 'M'
			End
	End AS QtyShipNotInv, N.CpnyID
FROM	INTran N JOIN Inventory I ON
	N.InvtID = I.InvtID
WHERE	N.Rlsed = 0			-- unreleased only
	AND N.JrnlType = 'OM'		-- from OM generated trans
	AND N.S4Future09 = 0		-- QtyNoUpdate (stock item only)
	AND (N.TranType IN ('IN', 'TR') OR (N.TranType = 'AS' AND LEN(N.KitID) > 0))
	AND (N.Qty * N.InvtMult) < 0	-- only for outgoing transactions
	AND I.LotSerTrack = 'NN'	-- not lot/serial tracked

UNION

--IN Side	Lot/Serial Items
SELECT 	N.InvtID, N.SiteID, N.WhseLoc, L.LotSerNbr, N.SpecificCostID, (L.Qty * N.InvtMult * -1) AS QtyShipNotInv, n.CpnyID
FROM 	INTran N JOIN LotSerT L ON
	N.CpnyID = L.CpnyID AND
	N.BatNbr = L.BatNbr AND
	N.LineRef = L.INTranLineRef AND
	N.SiteID = L.SiteID AND
	N.TranType = L.TranType
WHERE 	N.Rlsed = 0			-- unreleased only
	AND N.JrnlType = 'OM'		-- from OM generated trans
	AND N.S4Future09 = 0		-- QtyNoUpdate (stock item only)
	AND (N.TranType IN ('IN', 'TR') OR (N.TranType = 'AS' AND LEN(N.KitID) > 0))
	AND (N.Qty * N.InvtMult) < 0	-- only for outgoing transactions

 
