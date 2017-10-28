 Create	Procedure SCM_10990_INTran_NoLotSerT
	@InvtIDParm VARCHAR (30)
As
/*	This procedure will look for missing LotSerT transactions.	*/
	Select	LotSerT.InvtID, INTran.BatNbr, INTran.CpnyID, INTran.InvtID, INTran.LayerType,
		INTran.LineRef, INTran.RcptDate, INTran.RcptNbr, INTran.RefNbr, INTran.SiteID,
		INTran.SpecificCostID, INTran.TranType, INTran.WhseLoc
		From	INTran (NoLock) Inner Join Inventory (NoLock)
			On INTran.InvtID = Inventory.InvtID
			Left Join LotSerT (NoLock)
			On INTran.BatNbr = LotSerT.BatNbr
			And INTran.CpnyID = LotSerT.CpnyID
			And INTran.LineRef = LotSerT.INTranLineRef
			And INTran.SiteID = LotSerT.SiteID
			AND INTran.TranType = LOTSERT.TranType
		Where	(Inventory.SerAssign = 'R'
			Or (Inventory.SerAssign = 'U' And INTran.Qty * INTran.InvtMult < 0))
			And Inventory.LotSerTrack In ('LI', 'SI')
			And LotSerT.BatNbr Is Null
			And INTran.TranType Not In ('CG', 'CT')
			And (INTran.BatNbr <> '' and INTran.TranType <> 'AB')
			And INTran.Rlsed = 1
			And INTran.LotSerCntr > 0
			And 1 = Case 	When INTran.Qty * INTran.InvtMult = 0 Then 0
					When INTran.S4Future09 In (1, 2) Then 0
					When RTrim(INTran.JrnlType) = 'OM' And RTrim(INTran.TranType) = 'DM' Then 0
					Else 1
				End
			AND INTran.InvtID LIKE @InvtIDParm
		Order By INTran.InvtID


