 CREATE PROCEDURE SCM_10400_LotSerT_Validation
	@RecordID		Integer,
	@BatNbr			VarChar(10),
	@ProcessName		VarChar(8),
	@UserName		VarChar(10),
	@UserAddress		VarChar(21),
	@SerAssign		Char(1),
	@LotSerTrack		Char(2),
	@BaseDecPl		SmallInt,
	@BMIDecPl		SmallInt,
	@DecPlPrcCst		SmallInt,
	@DecPlQty		SmallInt
As
	Set NoCount On
	/*
	This PROCEDURE will audit the Lot Serial Transactions for the current batch
	to determine that the quantities in the lot serial transaction table are
	equal with the quantities in the INTRAN table for all lot or serial
	cONtrolled inventory items within the current Batch.

	*/

	/*
	This check to see IF there are records in the LotSerT table matching records in the
	intran table
	*/

	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
		Parm00, Parm01, Parm02, Parm03)
	SELECT	INTran.BatNbr, @UserAddress, 'SCM_10400_LOTSERT_Validation', 16089, 3,
		INTran.LineRef, INTran.BatNbr, INTran.InvtID, INTran.RecordID
		FROM	INTran (NoLock) Left Join LotSerT (NoLock)
			On INTran.BatNbr = LotSerT.BatNbr
			And INTran.CpnyID = LotSerT.CpnyID
			And INTran.LineRef = LotSerT.INTranLineRef
			And INTran.SiteID = LotSerT.SiteID
			AND INTran.TranType = LOTSERT.TranType
		WHERE	INTran.RecordID = @RecordID
			And (@SerAssign = 'R'
			Or (@SerAssign = 'U' And INTran.Qty * INTran.InvtMult < 0 And INTran.TranType <> 'PI' And INTran.TranType <> 'TR' And JrnlType <> 'PO'))
			And LotSerT.BatNbr IS Null
			And 1 = Case 	When INTran.Qty * INTran.InvtMult = 0 Then 0
					When INTran.S4Future09 In (1, 2) Then 0
					When RTrim(INTran.JrnlType) = 'OM' And RTrim(INTran.TranType) = 'DM' Then 0
					Else 1
				End
	/*
	This check to see IF the quantities between the lotsert and intran tables are balanced.
	*/

	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
		Parm00, Parm01, Parm02, Parm03)
	SELECT	INTran.BatNbr, @UserAddress, 'SCM_10400_LOTSERT_Validation', 16090, 3,
		INTran.LineRef, INTran.BatNbr, INTran.InvtID, @RecordID
		FROM	INTran (NoLock) Left Join LotSerT (NoLock)
			On INTran.BatNbr = LotSerT.BatNbr
			And INTran.CpnyID = LotSerT.CpnyID
			And INTran.LineRef = LotSerT.INTranLineRef
			And INTran.SiteID = LotSerT.SiteID
			AND INTran.TranType = LotSerT.TranType
		WHERE	INTran.Rlsed = 0
			And LotSerT.Rlsed = 0
			And INTran.RecordID = @RecordID
	 	GROUP BY INTran.BatNbr, INTran.LineRef, INTran.InvtID, INTran.Qty, INTran.CnvFact, INTran.UnitMultDiv
		HAVING 	Not (@SerAssign = 'U' And @LotSerTrack = 'SI' And (Max(INTran.TranType) = 'CM' Or Max(INTran.TranType) = 'RI')) And
			   Case When INTran.UnitMultDiv = 'M' Then
			   	(Round(Abs(INTran.Qty) * INTran.CnvFact, @DecPlQty))
			   Else (Round(Abs(INTran.Qty) / INTran.CnvFact, @DecPlQty)) end <> Round(SUM(ABS(LotSerT.Qty)), @DecPlQty)
			   Or
			   Case When INTran.UnitMultDiv = 'M' Then
			   	(Round(Abs(INTran.Qty) * INTran.CnvFact, @DecPlQty))
			   Else (Round(Abs(INTran.Qty) / INTran.CnvFact, @DecPlQty)) end < Round(SUM(ABS(LotSerT.Qty)), @DecPlQty)


