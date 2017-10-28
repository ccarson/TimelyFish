 Create Proc ADG_DeleteAlloc_smServDetail
	@ServiceCallID		Varchar(10),
	@LineID			SmallInt
AS
	UPDATE	L
	SET	QtyAllocSD = CASE WHEN CONVERT(DEC(25,9), L.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) < 0 THEN 0
			ELSE CONVERT(DEC(25,9), L.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) END,
		QtyAvail = CONVERT(DEC(25,9), L.QtyAvail) +
			CASE WHEN CONVERT(DEC(25,9), L.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) < 0
			THEN CONVERT(DEC(25,9), L.QtyAllocSD)
			ELSE CONVERT(DEC(25,9), D.QtyAllocSD) END
	FROM	Location L
	JOIN	(SELECT smServDetail.InvtID, smServDetail.SiteID, smServDetail.WhseLoc,
		QtyAllocSD = round(sum(case when COALESCE(u1.MultDiv, u2.MultDiv, u3.MultDiv, 'M') = 'D' then
						case when COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1) <> 0 then
							round(smServDetail.Quantity / COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), INSetup.DecPlQty)
						else
							0
						end
						else
							round(smServDetail.Quantity * COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), INSetup.DecPlQty)
						end), MAX(INSetup.DecPlQty))
				FROM	smServCall
				JOIN	smServDetail ON
					smServCall.ServiceCallID = smServDetail.ServiceCallID
				JOIN	LocTable ON
					smServDetail.SiteID = LocTable.SiteID
					AND smServDetail.WhseLoc = LocTable.WhseLoc
				JOIN	Inventory ON
					smServDetail.InvtID = Inventory.InvtID
					AND Inventory.StkItem = 1
				JOIN	INSetup (NOLOCK) ON
					INSetup.SetupID = 'IN'
				LEFT JOIN INUnit u1 ON
					u1.FromUnit = Inventory.DfltSOUnit
					AND u1.ToUnit = Inventory.StkUnit
					AND u1.UnitType = '3'
					AND u1.InvtID = Inventory.InvtID
				LEFT JOIN INUnit u2 ON
					u2.FromUnit = Inventory.DfltSOUnit
					AND u2.ToUnit = Inventory.StkUnit
					AND u2.UnitType = '2'
					AND u2.ClassID = Inventory.ClassID
				LEFT JOIN INUnit u3 ON
					u3.FromUnit = Inventory.DfltSOUnit
					AND u3.ToUnit = Inventory.StkUnit
					AND u3.UnitType = '1'
				WHERE	smServCall.ServiceCallID = @ServiceCallID
					AND smServDetail.BillingType = 'F'
					AND smServDetail.FlatRateLineNbr = @LineID
					AND smServCall.ServiceCallStatus <> 'C'
					AND smServDetail.Quantity > 0
					AND LocTable.InclQtyAvail = 1
				GROUP BY smServDetail.InvtID, smServDetail.SiteID, smServDetail.WhseLoc) D
	ON	D.InvtId = L.InvtID
	AND	D.SiteID = L.SiteID
	AND	D.WhseLoc = L.WhseLoc

	UPDATE	M
	SET	QtyAllocSD = CASE WHEN CONVERT(DEC(25,9), M.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) < 0 THEN 0
			ELSE CONVERT(DEC(25,9), M.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) END,
		QtyAvail = CONVERT(DEC(25,9), M.QtyAvail) +
			CASE WHEN CONVERT(DEC(25,9), M.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) < 0
			THEN CONVERT(DEC(25,9), M.QtyAllocSD)
			ELSE CONVERT(DEC(25,9), D.QtyAllocSD) END
	FROM	LotSerMst M
	JOIN	(SELECT smServDetail.InvtID, smServDetail.SiteID, smServDetail.WhseLoc, smServDetail.LotSerialRep,
		QtyAllocSD = round(sum(case when COALESCE(u1.MultDiv, u2.MultDiv, u3.MultDiv, 'M') = 'D' then
						case when COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1) <> 0 then
							round(smServDetail.Quantity / COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), INSetup.DecPlQty)
						else
							0
						end
						else
							round(smServDetail.Quantity * COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), INSetup.DecPlQty)
						end), MAX(INSetup.DecPlQty))
				FROM	smServCall
				JOIN	smServDetail ON
					smServCall.ServiceCallID = smServDetail.ServiceCallID
				JOIN	LocTable ON
					smServDetail.SiteID = LocTable.SiteID
					AND smServDetail.WhseLoc = LocTable.WhseLoc
				JOIN	Inventory ON
					smServDetail.InvtID = Inventory.InvtID
					AND Inventory.StkItem = 1
					AND Inventory.LotSerTrack IN ('LI','SI')
					AND Inventory.SerAssign = 'R'
				JOIN	INSetup (NOLOCK) ON
					INSetup.SetupID = 'IN'
				LEFT JOIN INUnit u1 ON
					u1.FromUnit = Inventory.DfltSOUnit
					AND u1.ToUnit = Inventory.StkUnit
					AND u1.UnitType = '3'
					AND u1.InvtID = Inventory.InvtID
				LEFT JOIN INUnit u2 ON
					u2.FromUnit = Inventory.DfltSOUnit
					AND u2.ToUnit = Inventory.StkUnit
					AND u2.UnitType = '2'
					AND u2.ClassID = Inventory.ClassID
				LEFT JOIN INUnit u3 ON
					u3.FromUnit = Inventory.DfltSOUnit
					AND u3.ToUnit = Inventory.StkUnit
					AND u3.UnitType = '1'
				WHERE	smServCall.ServiceCallID = @ServiceCallID
					AND smServDetail.BillingType = 'F'
					AND smServDetail.FlatRateLineNbr = @LineID
					AND smServCall.ServiceCallStatus <> 'C'
					AND smServDetail.Quantity > 0
					AND LocTable.InclQtyAvail = 1
				GROUP BY smServDetail.InvtID, smServDetail.SiteID, smServDetail.WhseLoc, smServDetail.LotSerialRep) D
	ON	D.InvtId = M.InvtID
	AND	D.SiteID = M.SiteID
	AND	D.WhseLoc = M.WhseLoc
	AND	D.LotSerialRep = M.LotSerNbr

	UPDATE	S
	SET	QtyAllocSD = CASE WHEN CONVERT(DEC(25,9), S.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) < 0 THEN 0
			ELSE CONVERT(DEC(25,9), S.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) END,
		QtyAvail = CONVERT(DEC(25,9), S.QtyAvail) +
			CASE WHEN CONVERT(DEC(25,9), S.QtyAllocSD) - CONVERT(DEC(25,9), D.QtyAllocSD) < 0
			THEN CONVERT(DEC(25,9), S.QtyAllocSD)
			ELSE CONVERT(DEC(25,9), D.QtyAllocSD) END
	FROM	ItemSite S
	JOIN	(SELECT smServDetail.InvtID, smServDetail.SiteID,
		QtyAllocSD = round(sum(case when COALESCE(u1.MultDiv, u2.MultDiv, u3.MultDiv, 'M') = 'D' then
						case when COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1) <> 0 then
							round(smServDetail.Quantity / COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), INSetup.DecPlQty)
						else
							0
						end
						else
							round(smServDetail.Quantity * COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), INSetup.DecPlQty)
						end), MAX(INSetup.DecPlQty))
				FROM	smServCall
				JOIN	smServDetail ON
					smServCall.ServiceCallID = smServDetail.ServiceCallID
				JOIN	LocTable ON
					smServDetail.SiteID = LocTable.SiteID
					AND smServDetail.WhseLoc = LocTable.WhseLoc
				JOIN	Inventory ON
					smServDetail.InvtID = Inventory.InvtID
					AND Inventory.StkItem = 1
				JOIN	INSetup (NOLOCK) ON
					INSetup.SetupID = 'IN'
				LEFT JOIN INUnit u1 ON
					u1.FromUnit = Inventory.DfltSOUnit
					AND u1.ToUnit = Inventory.StkUnit
					AND u1.UnitType = '3'
					AND u1.InvtID = Inventory.InvtID
				LEFT JOIN INUnit u2 ON
					u2.FromUnit = Inventory.DfltSOUnit
					AND u2.ToUnit = Inventory.StkUnit
					AND u2.UnitType = '2'
					AND u2.ClassID = Inventory.ClassID
				LEFT JOIN INUnit u3 ON
					u3.FromUnit = Inventory.DfltSOUnit
					AND u3.ToUnit = Inventory.StkUnit
					AND u3.UnitType = '1'
				WHERE	smServCall.ServiceCallID = @ServiceCallID
					AND smServDetail.BillingType = 'F'
					AND smServDetail.FlatRateLineNbr = @LineID
					AND smServCall.ServiceCallStatus <> 'C'
					AND smServDetail.Quantity > 0
					AND LocTable.InclQtyAvail = 1
				GROUP BY smServDetail.InvtID, smServDetail.SiteID, smServDetail.WhseLoc) D
	ON	D.InvtId = S.InvtID
	AND	D.SiteID = S.SiteID


