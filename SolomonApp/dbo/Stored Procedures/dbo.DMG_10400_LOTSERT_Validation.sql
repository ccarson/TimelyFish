 CREATE PROCEDURE DMG_10400_LOTSERT_Validation
	/*BEGIN Parameters*/
	@BatNbr			VARCHAR(10),
	@ProcessName		VARCHAR(8),
	@UserName		VARCHAR(10),
	@UserAddress		VARCHAR(21),
	@BaseDecPl 		SmallInt,
	@BMIDecPl 		SmallInt,
	@DecPlPrcCst		SmallInt,
	@DecPlQty		SmallInt
	/*END Parameters*/
As

	SET NOCOUNT ON
	/*
	This PROCEDURE will audit the Lot Serial Transactions for the current batch
	to determine that the quantities in the lot serial transaction table are
	equal with the quantities in the INTRAN table for all lot or serial
	cONtrolled inventory items within the current Batch.

	Returns:	@True = 1	The PROCEDURE executed properly.
			@False = 0	An error occurred.
	*/

-- Error Trapping
DECLARE	@SQLErrorNbr	SMALLINT,
	@True		BIT,
	@False		BIT
SELECT	@True 		= 1,
	@False 		= 0

-- CURSOR Fields
DECLARE	@c_BatNbr	CHAR(10),
	@c_LineRef	CHAR(5),
	@c_InvtID	CHAR(30),
	@c_SiteID	CHAR(10),
	@c_WhseLoc 	CHAR(10),
	@c_TranQty	FLOAT,
	@c_Lot_Qty	FLOAT

/*
This check to see IF there are records in the lotsert table matching records in the
intran table
*/

IF CURSOR_STATUS('Local', 'LOTSERT_Validate_1_CURSOR') > 0
BEGIN
	CLOSE LOTSERT_Validate_1_CURSOR
	DEALLOCATE LOTSERT_Validate_1_CURSOR
END

DECLARE LOTSERT_Validate_1_CURSOR CURSOR LOCAL FOR
SELECT	INTran.BatNbr, INTran.LineRef, INTran.InvtID, INTran.SiteID, INTran.WhseLoc
	FROM	INTran Join Inventory
		ON INTran.InvtID = Inventory.InvtID
		Left Join LotSerT
		On INTran.BatNbr = LotSerT.BatNbr
		And INTran.CpnyID = LotSerT.CpnyID
		And INTran.LineRef = LotSerT.INTranLineRef
		And INTran.SiteID = LotSerT.SiteID
		AND INTran.TranType = LOTSERT.TranType
	WHERE	INTran.BatNbr = @BatNbr
		And Inventory.LotSerTrack In ('LI', 'SI')
		And (Inventory.SerAssign = 'R'
		Or (Inventory.SerAssign = 'U' And INTran.Qty * INTran.InvtMult < 0))
		And LotSerT.BatNbr IS Null
		And 1 = Case 	When INTran.Qty * INTran.InvtMult = 0 Then 0
				When INTran.S4Future09 In (1, 2) Then 0
				When RTrim(INTran.JrnlType) = 'OM' And RTrim(INTran.TranType) = 'DM' Then 0
				Else 1
			End
	ORDER BY INTran.LineRef

OPEN LOTSERT_Validate_1_CURSOR

FETCH NEXT FROM LOTSERT_Validate_1_CURSOR INTO @c_BatNbr, @c_LineRef, @c_InvtID, @c_SiteId, @c_WhseLoc

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0
BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00, Parm01, Parm02)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_LOTSERT_Validation', @SQLErrorNbr, 3,
		 @c_LineRef, @c_BatNbr, @c_InvtID)
	GOTO Abort
END

WHILE  @@FETCH_STATUS = 0
	BEGIN
		BEGIN     -- *********** InTran Loop
		/*
		Solomon Error Message
		*/
			INSERT 	INTO IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
				Parm00, Parm01, Parm02)
				VALUES
				(@BatNbr, @UserAddress, 'DMG_10400_LOTSERT_Validation', 16089, 3,
				 @c_LineRef, @c_BatNbr, @c_InvtID)
		END

		FETCH NEXT FROM LOTSERT_Validate_1_CURSOR INTO @c_BatNbr, @c_LineRef, @c_InvtID, @c_SiteId, @c_WhseLoc

	END

/*
This check to see IF the quantities between the lotsert and intran tables are balanced.
*/

IF CURSOR_STATUS('Local', 'LOTSERT_Validate_2_CURSOR') > 0
BEGIN
	CLOSE LOTSERT_Validate_2_CURSOR
	DEALLOCATE LOTSERT_Validate_2_CURSOR
END

DECLARE LOTSERT_Validate_2_CURSOR CURSOR LOCAL FOR
SELECT	INTran.BatNbr, INTran.LineRef, INTran.InvtID, INTran.SiteID, INTran.WhseLoc,
	Tran_Qty = Case When INTran.UnitMultDiv = 'M' Then
		   	(Round(Abs(INTran.Qty) * INTran.CnvFact, @DecPlQty))
		   Else (Round(Abs(INTran.Qty) / INTran.CnvFact, @DecPlQty)) end,
	Lot_Qty = Round(Sum(Abs(LotSerT.Qty)), @DecPlQty)
	FROM	INTran Join Inventory
		ON INTran.InvtID = Inventory.InvtID
		Left Join LotSerT
		On INTran.BatNbr = LotSerT.BatNbr
		And INTran.CpnyID = LotSerT.CpnyID
		And INTran.LineRef = LotSerT.INTranLineRef
		And INTran.SiteID = LotSerT.SiteID
		AND INTran.TranType = LotSerT.TranType
	WHERE	INTran.Rlsed = 0
		And LotSerT.Rlsed = 0
		And Inventory.LotSerTrack In ('LI', 'SI')
		And INTran.BatNbr = @BatNbr
 	GROUP BY INTran.BatNbr, INTran.LineRef, INTran.InvtID, INTran.SiteID, INTran.WhseLoc, INTran.Qty, INTran.CnvFact, INTran.UnitMultDiv
	HAVING 	Case When INTran.UnitMultDiv = 'M' Then
		   	(Round(Abs(INTran.Qty) * INTran.CnvFact, @DecPlQty))
		   Else (Round(Abs(INTran.Qty) / INTran.CnvFact, @DecPlQty)) end <> Round(SUM(ABS(LotSerT.Qty)), @DecPlQty)

OPEN LOTSERT_Validate_2_CURSOR

FETCH NEXT FROM LOTSERT_Validate_2_CURSOR INTO 	@c_BatNbr, @c_LineRef, @c_InvtID, @c_SiteId, @c_WhseLoc,
						@c_TranQty, @c_Lot_Qty

SELECT @SQLErrorNbr = @@ERROR
IF @SQLErrorNbr <> 0
BEGIN
	INSERT 	INTO IN10400_RETURN
		(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
		Parm00, Parm01, Parm02)
	VALUES
		(@BatNbr, @UserAddress, 'DMG_10400_LOTSERT_Validation', @SQLErrorNbr, 3,
		 @c_LineRef, @c_BatNbr, @c_InvtID)
	GOTO Abort
END

WHILE  @@FETCH_STATUS = 0
	BEGIN
		BEGIN     -- *********** InTran Loop
		/*
		Solomon Error Message
		*/
			INSERT 	INTO IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, MsgNbr, ParmCnt,
				Parm00, Parm01, Parm02)
				VALUES
				(@BatNbr, @UserAddress, 'DMG_10400_LOTSERT_Validation', 16090, 3,
				 @c_LineRef, @c_BatNbr, @c_InvtID)
		END

		FETCH NEXT FROM LOTSERT_Validate_2_CURSOR INTO 	@c_BatNbr, @c_LineRef, @c_InvtID, @c_SiteId, @c_WhseLoc,
							@c_TranQty, @c_Lot_Qty

	END

	CLOSE LOTSERT_Validate_1_CURSOR
	DEALLOCATE LOTSERT_Validate_1_CURSOR
	CLOSE LOTSERT_Validate_2_CURSOR
	DEALLOCATE LOTSERT_Validate_2_CURSOR

GOTO Finish

Abort:
	IF CURSOR_STATUS('Local', 'LOTSERT_Validate_1_CURSOR') > 0
	BEGIN
		CLOSE LOTSERT_Validate_1_CURSOR
		DEALLOCATE LOTSERT_Validate_1_CURSOR
	END
	IF CURSOR_STATUS('Local', 'LOTSERT_Validate_2_CURSOR') > 0
	BEGIN
		CLOSE LOTSERT_Validate_2_CURSOR
		DEALLOCATE LOTSERT_Validate_2_CURSOR
	END
	RETURN @False

Finish:
	RETURN @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_LOTSERT_Validation] TO [MSDSL]
    AS [dbo];

