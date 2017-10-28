 Create Procedure SCM_Plan_OtherQty
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@QtyPrec	SmallInt
AS
	SET NOCOUNT ON

	update	LotSerMst
		set	QtyAllocSD = isnull((select round(sum(
						case when COALESCE(u1.MultDiv, u2.MultDiv, u3.MultDiv, 'M') = 'D' then
						case when COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1) <> 0 then
							round(smServDetail.Quantity / COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @QtyPrec)
						else
							0
						end
						else
							round(smServDetail.Quantity * COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @QtyPrec)
						end), @QtyPrec)
				FROM	smServCall
				JOIN	smServDetail ON
					smServCall.ServiceCallID = smServDetail.ServiceCallID
				JOIN	LocTable ON
					smServDetail.SiteID = LocTable.SiteID
					AND smServDetail.WhseLoc = LocTable.WhseLoc
				JOIN	Inventory ON
					smServDetail.InvtID = Inventory.InvtID
					AND Inventory.LotSerTrack IN ('LI','SI')
					AND Inventory.SerAssign = 'R'
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
				WHERE	smServCall.ServiceCallStatus <> 'Q'
					AND smServDetail.InvtId = LotSerMst.InvtID
					AND smServDetail.SiteID = LotSerMst.SiteID
					AND smServDetail.WhseLoc = LotSerMst.WhseLoc
					AND smServDetail.LotSerialRep = LotSerMst.LotSerNbr
					AND smServDetail.LotSerialRep <> ''
					AND smServDetail.INBatNbr = '' -- grab only the trans that aren't in an IN batch yet
					AND smServDetail.Quantity > 0
					AND LocTable.InclQtyAvail = 1), 0)
	from	LotSerMst
	join	INUpdateQty_Wrk INU (NOLOCK)
	ON 	INU.InvtID = LotSerMst.InvtID					/* Inventory ID */
	AND 	INU.SiteID = LotSerMst.SiteID					/* Site ID */
	AND	INU.ComputerName + '' LIKE @ComputerName

	update	M
	set	QtyAllocBM = round(isnull(D.QtyAllocBM, 0), @QtyPrec),
		QtyAllocIN = round(isnull(D.QtyAllocIN, 0), @QtyPrec),
		QtyAllocPORet = round(isnull(D.QtyAllocPORet, 0), @QtyPrec),
		QtyAllocSD = round(M.QtyAllocSD + isnull(D.QtyAllocSD, 0), @QtyPrec)
	from	LotSerMst M
	join	INUpdateQty_Wrk INU (NOLOCK)
	ON 	INU.InvtID = M.InvtID					/* Inventory ID */
	AND 	INU.SiteID = M.SiteID					/* Site ID */
	AND	INU.ComputerName + '' LIKE @ComputerName
	join	Inventory (NOLOCK)
	ON 	INU.InvtID = Inventory.InvtID
	AND	Inventory.LotSerTrack IN ('LI','SI')
	AND 	Inventory.SerAssign = 'R'
	left join
		(select LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr,
				QtyAllocBM = round(sum(case when LotSerT.TranSrc = 'BM'
						or (LotSerT.TranSrc = 'IN' and LotSerT.Crtd_Prog Like '11%') then
						-LotSerT.InvtMult * LotSerT.Qty else 0 end), @QtyPrec),
				QtyAllocIN = round(sum(case when LotSerT.TranSrc = 'IN' and LotSerT.Crtd_Prog not like 'SD%'
						and LotSerT.Crtd_Prog not like '11%' then
						-LotSerT.InvtMult * LotSerT.Qty else 0 end), @QtyPrec),
				QtyAllocPORet = round(sum(case when LotSerT.TranSrc = 'PO' then
						-LotSerT.InvtMult * LotSerT.Qty else 0 end), @QtyPrec),
				QtyAllocSD = round(sum(case when LotSerT.Crtd_Prog LIKE 'SD%' then
						-LotSerT.InvtMult * LotSerT.Qty else 0 end), @QtyPrec)
				from	LotSerT
				   JOIN INUpdateQty_Wrk INU (NOLOCK)
					 ON INU.InvtID = LotSerT.InvtID /* Inventory ID */
						AND INU.SiteID = LotSerT.SiteID /* Site ID */
						AND INU.ComputerName + '' LIKE @ComputerName
				   JOIN LocTable
					 ON LotSerT.SiteID = LocTable.SiteID
						AND LotSerT.WhseLoc = LocTable.WhseLoc
						AND LocTable.InclQtyAvail = 1
				where	LotSerT.InvtMult * LotSerT.Qty < 0
				and	LotSerT.Rlsed = 0
				and	LotSerT.TranType IN ('II','IN','DM','TR','AS','AJ')
				group by LotSerT.InvtID, LotSerT.SiteID, LotSerT.WhseLoc, LotSerT.LotSerNbr) D
	on	M.InvtID = D.InvtID
	and	M.SiteID = D.SiteID
	and	M.WhseLoc = D.WhseLoc
	and	M.LotSerNbr = D.LotSerNbr

	update	Location
	set	QtyAllocBM = isnull((select round(sum(BOMTran.CmpnentQty), @QtyPrec)
				from	BOMDoc, BOMTran, LocTable
				where	BOMTran.CmpnentID = Location.InvtID
				and	BOMTran.SiteID = Location.SiteID
				and	BOMTran.WhseLoc = Location.WhseLoc
				and	BOMDoc.RefNbr = BOMTran.RefNbr
				and	BOMDoc.Rlsed = 0
				and	BOMTran.CmpnentQty > 0
				and	BOMTran.SiteID = LocTable.SiteID
				and	BOMTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1
				and	not exists(select * from INTran where INTran.BatNbr = BOMTran.BatNbr and INTran.LineRef = BOMTran.LineRef)), 0)
	from	Location
	join	INUpdateQty_Wrk INU (NOLOCK)
	ON 	INU.InvtID = Location.InvtID					/* Inventory ID */
	AND 	INU.SiteID = Location.SiteID					/* Site ID */
	AND	INU.ComputerName + '' LIKE @ComputerName

	update	Location
	set	QtyAllocPORet = isnull((select round(sum(case when POTran.UnitMultDiv = 'D' then
						case when POTran.CnvFact <> 0 then
							round(POTran.Qty / POTran.CnvFact, @QtyPrec)
						else
							0
						end
						else
							round(POTran.Qty * POTran.CnvFact, @QtyPrec)
						end), @QtyPrec)
				from	POReceipt, POTran, LocTable
				where	POTran.InvtID = Location.InvtID
				and	POTran.SiteID = Location.SiteID
				and	POTran.WhseLoc = Location.WhseLoc
				and	POReceipt.RcptNbr = POTRan.RcptNbr
				and	POTran.TranType = 'X'
				and	POTran.PurchaseType IN ('GI','PI')
				and	POReceipt.Rlsed = 0
				and	POTran.SiteID = LocTable.SiteID
				and	POTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1), 0)
	from	Location
	join	INUpdateQty_Wrk INU (NOLOCK)
	ON 	INU.InvtID = Location.InvtID					/* Inventory ID */
	AND 	INU.SiteID = Location.SiteID					/* Site ID */
	AND	INU.ComputerName + '' LIKE @ComputerName

	update	Location
	set	QtyAllocSD = isnull((select round(sum(
						case when COALESCE(u1.MultDiv, u2.MultDiv, u3.MultDiv, 'M') = 'D' then
						case when COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1) <> 0 then
							round(smServDetail.Quantity / COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @QtyPrec)
						else
							0
						end
						else
							round(smServDetail.Quantity * COALESCE(u1.CnvFact, u2.CnvFact, u3.CnvFact, 1), @QtyPrec)
						end), @QtyPrec)
				FROM	smServCall
				JOIN	smServDetail ON
					smServCall.ServiceCallID = smServDetail.ServiceCallID
				JOIN	LocTable ON
					smServDetail.SiteID = LocTable.SiteID
					AND smServDetail.WhseLoc = LocTable.WhseLoc
				JOIN	Inventory ON smServDetail.InvtID = Inventory.InvtID
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
				WHERE smServCall.ServiceCallStatus <> 'Q'
					AND smServDetail.InvtId = Location.InvtId
					AND smServDetail.SiteID = Location.SiteID
					AND smServDetail.WhseLoc = Location.WhseLoc
					AND smServDetail.INBatNbr = '' -- grab only the trans that aren't in an IN batch yet
					AND smServDetail.Quantity > 0
					AND LocTable.InclQtyAvail = 1), 0)
	from	Location
	join	INUpdateQty_Wrk INU (NOLOCK)
	ON 	INU.InvtID = Location.InvtID					/* Inventory ID */
	AND 	INU.SiteID = Location.SiteID					/* Site ID */
	AND	INU.ComputerName + '' LIKE @ComputerName

	update	L
	set	QtyAllocBM = round(L.QtyAllocBM + isnull(D.QtyAllocBM, 0), @QtyPrec),
		QtyAllocIN = round(isnull(D.QtyAllocIN, 0), @QtyPrec),
		QtyAllocPORet = round(L.QtyAllocPORet + isnull(D.QtyAllocPORet, 0), @QtyPrec),
		QtyAllocSD = round(L.QtyAllocSD + isnull(D.QtyAllocSD, 0), @QtyPrec)
	from	Location L
	join	INUpdateQty_Wrk INU (NOLOCK)
	ON 	INU.InvtID = L.InvtID					/* Inventory ID */
	AND 	INU.SiteID = L.SiteID					/* Site ID */
	AND	INU.ComputerName + '' LIKE @ComputerName
	left join
		(select INTran.InvtID, INTran.SiteID, INTran.WhseLoc,
				QtyAllocBM = round(sum(case when INTran.JrnlType = 'BM' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
							round(INTran.Qty / INTran.CnvFact, @QtyPrec)
						else
							0
						end
						else
							round(INTran.Qty * INTran.CnvFact, @QtyPrec)
						end else 0 end), @QtyPrec),
				QtyAllocIN = round(sum(case when INTran.JrnlType = 'IN' and INTran.Crtd_Prog not like 'SD%' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
						--- Store the absolute value of the intran value - the QtyAllocIN is initially
						---		positive while the INTran.Qty value is negative for negative allocations.
						---	    Leave the value positive since later computations subtract the value.
							Abs(round(INTran.Qty / INTran.CnvFact, @QtyPrec))
						else
							0
						end
						else
							Abs(round(INTran.Qty * INTran.CnvFact, @QtyPrec))
						end else 0 end), @QtyPrec),
				QtyAllocPORet = round(sum(case when INTran.JrnlType = 'PO' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
							round(INTran.Qty / INTran.CnvFact, @QtyPrec)
						else
							0
						end
						else
							round(INTran.Qty * INTran.CnvFact, @QtyPrec)
						end else 0 end), @QtyPrec),
				QtyAllocSD = round(sum(case when INTran.Crtd_Prog LIKE 'SD%' then
						case when INTran.UnitMultDiv = 'D' then
						case when INTran.CnvFact <> 0 then
							round(INTran.Qty / INTran.CnvFact, @QtyPrec)
						else
							0
						end
						else
							round(INTran.Qty * INTran.CnvFact, @QtyPrec)
						end else 0 end), @QtyPrec)
				from	INTran WITH(NOLOCK), LocTable
				where	INTran.S4Future09 = 0
				and	INTran.Rlsed = 0
				and	(INTran.TranType IN ('II','IN','DM','TR')
				or	INTran.TranType = 'AS' and INTran.InvtMult = -1
				or	INTran.TranType = 'AJ' and INTran.Qty < 0)
				and	INTran.SiteID = LocTable.SiteID
				and	INTran.WhseLoc = LocTable.WhseLoc
				and	LocTable.InclQtyAvail = 1
				group by INTran.InvtID, INTran.SiteID, INTran.WhseLoc) D
	on	L.InvtID = D.InvtID
	and	L.SiteID = D.SiteID
	and	L.WhseLoc = D.WhseLoc
		UPDATE	ItemSite
	SET	QtyAllocBM = round(coalesce(D.QtyAllocBM, 0), @QtyPrec),
		QtyAllocIN = round(coalesce(D.QtyAllocIN, 0), @QtyPrec),
		QtyAllocPORet = round(coalesce(D.QtyAllocPORet, 0), @QtyPrec),
		QtyAllocSD = round(coalesce(D.QtyAllocSD, 0), @QtyPrec),
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
		FROM	ItemSite
		JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON 	INU.InvtID = ItemSite.InvtID					/* Inventory ID */
	  AND 	INU.SiteID = ItemSite.SiteID					/* Site ID */
	  AND	INU.ComputerName + '' LIKE @ComputerName

	LEFT JOIN (SELECT Location.InvtID, Location.SiteID,
		QtyAllocBM = sum(QtyAllocBM),
		QtyAllocIN = sum(QtyAllocIN),
		QtyAllocPORet = sum(QtyAllocPORet),
		QtyAllocSD = sum(QtyAllocSD)
	from	Location
	JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON 	INU.InvtID = Location.InvtID					/* Inventory ID */
	  AND 	INU.SiteID = Location.SiteID					/* Site ID */
	  AND	INU.ComputerName + '' LIKE @ComputerName
	group by Location.InvtID, Location.SiteID) AS D

	  ON 	D.InvtID = ItemSite.InvtID					/* Inventory ID */
	  AND 	D.SiteID = ItemSite.SiteID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_OtherQty] TO [MSDSL]
    AS [dbo];

