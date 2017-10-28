 

CREATE VIEW vp_INCheck 
AS

/*
	This view will return standardized detail Inventory transactions from INTran and LotSerT.
*/
Select	Distinct INTran.BATNBR, INTran.LINEREF, INTran.CPNYID, INTran.InvtID, INTran.SiteID, INTran.WhseLoc,
	RefNbr =	Case	When	RTrim(INTran.JrnlType) = 'PO' 
					Then	INTran.RefNbr
				Else '' 
			End,
	LotSerNbr = 	Coalesce(Case	When	INTran.TranType IN ('CT', 'CG', 'AC')
						Then 	''
					When	Inventory.LotSerTrack IN ('LI', 'SI')
						Then	LotSerT.LotSerNbr
					Else ''
				End, ''),
	INTran.SpecificCostID,
	LayerType =	INTran.LayerType,
	Qty =	Coalesce(	Case	When	INTran.RLSED = 0
						Then	0
					When	INTran.S4Future05 <> 0
						Then	0
					When	INTran.S4Future09 <> 0
						Then	0
					When	INTran.TranType = 'AC'
						Then	0
					When	Inventory.LotSerTrack IN ('LI', 'SI')
						And INTran.LotSerCntr <> 0
						And (Inventory.SerAssign = 'R'
						Or (Inventory.SerAssign = 'U'
						And Round(INTran.QTY * INTran.InvtMult, Pl.DecPlQty) < 0))
						AND INTran.TranType NOT IN ('CG', 'CT')
						Then	Round(LOTSERT.QTY * LOTSERT.InvtMult, Pl.DecPlQty)
					When	INTran.CNVFACT IN (0, 1)
						Then	Round(INTran.QTY * INTran.InvtMult, Pl.DecPlQty)
					When	INTran.UNITMULTDIV = 'D'
						Then	Round((INTran.QTY / INTran.CNVFACT) * INTran.InvtMult, Pl.DecPlQty)
					Else	Round(INTran.QTY * INTran.CNVFACT * INTran.InvtMult, Pl.DecPlQty)
				End, 0),
	UnitCost =	Abs(Case	When	INTran.JRNLTYPE = 'OM' 
					And INTran.TranType NOT IN ('CG', 'CT') 
					And Inventory.ValMthd <> 'T'
					Then	Case	When	Round(INTran.Qty, Pl.DecPlQty) = 0
								Then	0
							When	INTran.CNVFACT IN (0, 1)
								Then	Round(INTran.EXTCOST / INTran.QTY, Pl.DecPlPrcCst)
							When	INTran.UNITMULTDIV = 'D'
								Then	Round(Round(INTran.EXTCOST / INTran.QTY, Pl.DecPlPrcCst) * INTran.CNVFACT, Pl.DecPlPrcCst)
							When	INTran.TranType IN ('CG', 'CT')
								Then	Round(Round(INTran.TranAmt / INTran.QTY, Pl.DecPlPrcCst) / INTran.CNVFACT, Pl.DecPlPrcCst)
							Else	Round(Round(INTran.EXTCOST / INTran.QTY, Pl.DecPlPrcCst) / INTran.CNVFACT, Pl.DecPlPrcCst)
						End
				When	Inventory.ValMthd = 'T'
					Then	Case	When	INSetup.MatlovhCalc = 'R'
								Then	Case	When	ItemSite.InvtID Is Not Null
											Then	ItemSite.StdCost
										Else	Inventory.StdCost
									End
							Else	Case	When	ItemSite.InvtID Is Not Null
										Then	ItemSite.DirStdCst
									Else	Inventory.DirStdCost
								End
						End
				When	INTran.CNVFACT IN (0, 1)
					Then	Round(INTran.UNITPRICE, Pl.DecPlPrcCst)
				When	INTran.UNITMULTDIV = 'D'
					Then	Round(INTran.UNITPRICE * INTran.CNVFACT, Pl.DecPlPrcCst)
				Else	Round(INTran.UNITPRICE / INTran.CNVFACT, Pl.DecPlPrcCst)
			End),
	TotCost = 	Case	When	INTran.RLSED = 0
					Then	0
				When	INTran.S4Future05 <> 0
					Then	0
				When	INTran.S4Future09 <> 0
					Then	0
				When	Inventory.ValMthd = 'U'
					Then	0
				When	INTran.TranType = 'AC'
					Then	0
				When	(RTrim(INTran.TranType) = 'AJ' And Round(INTran.QTY * INTran.InvtMult, Pl.DecPlQty) = 0)
					Or RTrim(INTran.TranType) In ('CM', 'DM') 
					Then	Coalesce(Case	When	Round(INTran.EXTCOST * INTran.InvtMult, Pl.BaseDecPl) <> 0
									Then	Round(INTran.EXTCOST * INTran.InvtMult, Pl.BaseDecPl)
								Else 	Round(INTran.TranAmt * INTran.InvtMult, Pl.BaseDecPl)
							End, 0)
				When	RTRIM(INTran.JRNLTYPE) = 'OM' 
					AND Inventory.LotSerTrack = 'SI'
					AND Round(INTran.EXTCOST * INTran.InvtMult, Pl.BaseDecPl) <> 0
					Then	Round(INTran.EXTCOST / INTran.QTY * INTran.InvtMult, Pl.BaseDecPl)
				When	RTRIM(INTran.JRNLTYPE) <> 'OM' 
					AND Round(INTran.EXTCOST * INTran.InvtMult, Pl.BaseDecPl) <> 0
					AND (Inventory.LotSerTrack NOT IN ('LI', 'SI')
					Or (Inventory.LotSerTrack In ('LI', 'SI') And INTran.LotSerCntr = 0))
					And Inventory.ValMthd <> 'T'
					Then	Round(INTran.EXTCOST * INTran.InvtMult, Pl.BaseDecPl)
				When	INTran.TranType IN ('CG', 'CT', 'RC') And Inventory.LotSerTrack NOT IN ('LI', 'SI')
					AND Round(INTran.EXTCOST * INTran.InvtMult, Pl.BaseDecPl) = 0
					AND Round(INTran.TRANAMT * INTran.InvtMult, Pl.BaseDecPl) <> 0
					Then	Round(INTran.TRANAMT * INTran.InvtMult, Pl.BaseDecPl)
				Else	Round((	Case	When	Inventory.LotSerTrack IN ('LI', 'SI')
								And INTran.LotSerCntr <> 0
								And (Inventory.SerAssign = 'R'
								Or (Inventory.SerAssign = 'U'
								And Round(INTran.QTY * INTran.InvtMult, Pl.DecPlQty) < 0))
								AND INTran.TranType NOT IN ('CG', 'CT')
								Then	Round(LOTSERT.QTY * LOTSERT.InvtMult, Pl.DecPlQty)
							When	INTran.CNVFACT IN (0, 1)
								Then	Round(INTran.QTY * INTran.InvtMult, Pl.DecPlQty)
							When	INTran.UNITMULTDIV = 'D'
								Then	Round((INTran.QTY / INTran.CNVFACT) * INTran.InvtMult, Pl.DecPlQty)
							Else	Round(INTran.QTY * INTran.CNVFACT * INTran.InvtMult, Pl.DecPlQty)
						End)
					* (	Case	When	INTran.JRNLTYPE = 'OM'  And INTran.TranType NOT IN ('CG', 'CT')
								Then	Case	When	Round(INTran.Qty, Pl.DecPlQty) = 0
											Then	0
										When	INTran.CNVFACT IN (0, 1)
											Then	Round(INTran.EXTCOST / INTran.QTY, Pl.DecPlPrcCst)
										When	INTran.UNITMULTDIV = 'D'
											Then	Round(Round(INTran.EXTCOST / INTran.QTY, Pl.DecPlPrcCst) * INTran.CNVFACT, Pl.DecPlPrcCst)
										When	INTran.TranType IN ('CG', 'CT')
											Then	Round(Round(INTran.TranAmt / INTran.QTY, Pl.DecPlPrcCst) / INTran.CNVFACT, Pl.DecPlPrcCst)
										Else	Round(Round(INTran.EXTCOST / INTran.QTY, Pl.DecPlPrcCst) / INTran.CNVFACT, Pl.DecPlPrcCst)
									End
							When	Inventory.ValMthd = 'T'
								Then	Case	When	INSetup.MatlovhCalc = 'R'
											Then	Case	When	ItemSite.InvtID Is Not Null
														Then	ItemSite.StdCost
													Else	Inventory.StdCost
												End
										Else	Case	When	ItemSite.InvtID Is Not Null
													Then	ItemSite.DirStdCst
												Else	Inventory.DirStdCost
											End
									End
							When	INTran.CNVFACT IN (0, 1)
								Then	Round(INTran.UNITPRICE, Pl.DecPlPrcCst)
							When	INTran.UNITMULTDIV = 'D'
								Then	Round(INTran.UNITPRICE * INTran.CNVFACT, Pl.DecPlPrcCst)
							Else	Round(INTran.UNITPRICE / INTran.CNVFACT, Pl.DecPlPrcCst)
						End), Pl.BaseDecPl)
			End,
	BMITotCost = 0,
	Rate = Coalesce(CuryRate.Rate, 1),
	RcptDate =	Case	When	Inventory.VALMTHD NOT IN ('F', 'L')
					Then	'01/01/1900'
				Else	INTran.RCPTDATE
			End,
	RcptNbr = 	Case	When	Inventory.VALMTHD = 'S'
					Then	''
				When	Inventory.VALMTHD NOT IN ('F', 'L') AND INTran.S4Future12 <> 'W'
					Then	''
				When	DATALENGTH(RTRIM(INTran.RCPTNBR)) = 0
					Then	Case	When	INTran.TranType IN ('AB') 
								AND INTran.QTY * INTran.InvtMult > 0
								Then	'1DMG'
							When	INTran.TranType IN ('CT', 'CG', 'AJ', 'AB')
								Then	'OVRSLD'
							Else	''
						End
				Else 	INTran.RCPTNBR 
			End, 
	INTran.TranDate, INTran.TranType, INTran.TranDesc, 
	CuryMultDiv = Coalesce(CuryRate.MultDiv, 'M'), Inventory.VALMTHD
	FROM	INSetup (NoLock), vp_DecPl Pl (NoLock),
		INTran JOIN Inventory (NoLock)
			ON INTran.InvtID = Inventory.InvtID
		Join vp_10990_ChangedItems Changed
			On INTran.InvtID = Changed.InvtID
		JOIN ITEMSITE (NoLock)
			ON INTran.InvtID = ITEMSITE.InvtID
			AND INTran.SiteID = ITEMSITE.SiteID
		LEFT JOIN LOTSERT (NoLock)
			ON INTran.BATNBR = LOTSERT.BATNBR
			AND INTran.CPNYID = LOTSERT.CPNYID
			AND INTran.LINEREF = LOTSERT.INTranLINEREF
			AND INTran.SiteID = LOTSERT.SiteID
			AND INTran.TranType = LOTSERT.TranType
			And LotSerT.Rlsed = 1
		LEFT JOIN CuryRate (NoLock)
			On CuryRate.FromCuryID = (Select BaseCuryID From GLSetup)
			And CuryRate.ToCuryID = INTran.BMICuryID 
			And CuryRate.RateType = Case When DataLength(RTrim(INTran.BMIRtTp)) = 0 Then (Select BMIDfltRtTp From INSetup) Else INTran.BMIRtTp End
			And CuryRate.EffDate <= Case When INTran.BMIEffDate = '01/01/1900' Then GetDate() Else INTran.BMIEffDate End
	WHERE	(INTran.TranType <> 'AB' 
		And 1 = Case	When	Inventory.ValMthd = 'T'
					And INSetup.MatlOvhCalc = 'U'
					And INTran.TranDesc = 'Overhead Entry'
					Then	0
				Else	1
			End)
		OR (INTran.TranType = 'AB' 
		AND (Inventory.LotSerTrack = 'NN'
		Or Inventory.SerAssign = 'U'))
Union
Select	Distinct LOTSERT.BATNBR, LOTSERT.INTranLINEREF, LOTSERT.CPNYID, LOTSERT.InvtID, LOTSERT.SiteID,
	LOTSERT.WhseLoc, RefNbr = '', LOTSERT.LOTSERNBR, SPECIFICCOSTID = '', LAYERTYPE = 'S',
	QTY =	Round(LOTSERT.QTY * LOTSERT.InvtMult, Pl.DecPlQty),
	UNITCOST =	0,
	TOTCOST =	0,
	BMITotCost = 	0,
	Rate = 		1,
	RCPTDATE =	'01/01/1900',
	RCPTNBR = 	'', 
	LotSerT.TranDate, LOTSERT.TranType, '', CuryMultDiv = 'M', Inventory.VALMTHD
	FROM	vp_DecPl Pl (NoLock), 
		LOTSERT
		JOIN Inventory (NoLock)
		ON LOTSERT.InvtID = Inventory.InvtID
		Join vp_10990_ChangedItems Changed
		On LotSerT.InvtID = Changed.InvtID
	WHERE	LOTSERT.S4Future05 = 0	/*  Retired Transactions	*/
		AND LOTSERT.RLSED = 1
		AND LOTSERT.TranType = 'AB'
		AND Inventory.LotSerTrack IN ('LI', 'SI')
		And Inventory.SerAssign <> 'U'
		AND (LOTSERT.QTY * LOTSERT.InvtMult) > 0
Union
Select	Distinct INTran.BATNBR, INTran.LINEREF, INTran.CPNYID, INTran.InvtID, INTran.SiteID, 
	INTran.WhseLoc, RefNbr = '', LOTSERNBR = '', INTran.SPECIFICCOSTID,
	LayerType = INTran.LayerType,
	QTY =	Round(INTran.QTY * INTran.InvtMult, Pl.DecPlQty),
	UNITCOST =	INTran.UNITPRICE,
	TOTCOST =	INTran.EXTCOST,
	BMITotCost = 0,
	Rate = 	1,
	RCPTDATE =	Case	When	Inventory.VALMTHD NOT IN ('F', 'L')
					Then	'01/01/1900'
				Else	INTran.RCPTDATE
			End,
	RCPTNBR = 	Case	When	Inventory.VALMTHD = 'S'
					Then	''
				When	Inventory.VALMTHD NOT IN ('F', 'L')
					Then	''
				When	DATALENGTH(RTRIM(INTran.RCPTNBR)) = 0
					Then	Case	When 	Round(INTran.QTY * INTran.InvtMult, Pl.DecPlQty) > 0 
								Then '1DMG'
							Else 	'OVRSLD'
					End
				Else 	INTran.RCPTNBR 
			End, 
	INTran.TranDate, INTran.TranType, INTran.TranDesc, CuryMultDiv = 'M', Inventory.VALMTHD
	FROM	vp_DecPl Pl (NoLock), 
		INTran JOIN Inventory (NoLock)
		ON INTran.InvtID = Inventory.InvtID
		Join vp_10990_ChangedItems Changed
		On INTran.InvtID = Changed.InvtID
	WHERE	INTran.S4Future05 = 0	/*  Retired Transactions	*/
		AND INTran.RLSED = 1
		AND INTran.TranType = 'AB'
		AND Inventory.LotSerTrack IN ('LI', 'SI')
		And Inventory.SerAssign <> 'U'


 
