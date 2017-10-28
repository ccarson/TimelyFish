 CREATE PROCEDURE DMG_10400_Upd_Order
	@SHIPPERID	VARCHAR(15),
	@BATNBR		VARCHAR(10),
	@CPNYID		VARCHAR(10),
	@LINEREF	VARCHAR(5),
	@INVCNBR	VARCHAR(15),
	@ProcessName	Varchar(8),
	@UserName	Varchar(10),
	@UserAddress	Varchar(21),
	@DECPLPRCCST	SmallInt
As
	Set NoCount On
	/*
	This procedure will update the cost on the original sales order line.

	Automatically determines if record to be updated exists.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/

	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt,
		@ReturnStatus	Bit
	Select	@SQLErrNbr	= 0,
		@ReturnStatus	= @True

	Declare	@COST		FLOAT
	Set	@COST = 0

	IF	EXISTS(SELECT	H.SHIPPERID, O.CuryMultDiv, O.CuryRate, OL.UnitMultDiv, OL.CnvFact
				FROM	SOSHIPHEADER H JOIN SOHEADER O
					ON H.ORDNBR = O.ORDNBR
					JOIN SOShipLine SL
					ON H.ShipperID = SL.ShipperID
					JOIN SOLINE OL
					ON SL.ORDNBR = OL.ORDNBR
					AND SL.OrdLineRef = OL.LineRef

				WHERE	H.SHIPPERID = @SHIPPERID
					AND H.INBATNBR = @BATNBR
					AND H.CPNYID = @CPNYID
					AND SL.LINEREF = @LINEREF
					AND H.INVCNBR = @INVCNBR)
	/*change joins for de 224541 */
	BEGIN
		Select	@COST = COALESCE(Round(Sum(ExtCost) / Sum(Case When UnitMultDiv = 'D' Then Qty / CnvFact Else Qty * CnvFact End), @DECPLPRCCST  ), 0)
			FROM	INTRAN
			WHERE	BATNBR = @BATNBR
				AND CPNYID = @CPNYID
				AND REFNBR = @INVCNBR
				AND ARLINEREF = @LINEREF
				AND TRANTYPE NOT IN ('CT', 'CG')
			GROUP BY BATNBR, CPNYID, ARLINEREF, REFNBR
	/*	Problem is this is the stocking UOM cost - next we need to convert to Selling UOM Cost	*/

		UPDATE	OL
 			SET	OL.COST	= ROUND(Case When OL.UnitMultDiv = 'D' Then @cost / OL.CnvFact Else @cost* OL.CnvFact End,@DECPLPRCCST),
				OL.TotCost = (ROUND(Case When OL.UnitMultDiv = 'D' Then @cost / OL.CnvFact Else @cost* OL.CnvFact End,@DECPLPRCCST)) * OL.QTYORD,
				OL.CURYCOST = (ROUND(Case When O.CuryMultDiv = 'D' Then (ROUND(Case When OL.UnitMultDiv = 'D' Then @cost / OL.CnvFact Else @cost* OL.CnvFact End,@DECPLPRCCST)) / (O.CuryRate) Else (ROUND(Case When OL.UnitMultDiv = 'D' Then @cost / OL.CnvFact Else @cost* OL.CnvFact End,@DECPLPRCCST))* O.CuryRate End, @DECPLPRCCST)),
				OL.CURYTOTCOST = ((ROUND(Case When O.CuryMultDiv = 'D' Then (ROUND(Case When OL.UnitMultDiv = 'D' Then @cost / OL.CnvFact Else @cost* OL.CnvFact End,@DECPLPRCCST)) / (O.CuryRate) Else (ROUND(Case When OL.UnitMultDiv = 'D' Then @cost / OL.CnvFact Else @cost* OL.CnvFact End,@DECPLPRCCST))* O.CuryRate End, @DECPLPRCCST)) ) * OL.QTYORD,
				OL.LUpd_DateTime = Convert(SmallDateTime, GetDate()),
				OL.LUpd_Prog = @ProcessName,
				OL.LUpd_User = @UserName
			FROM	SOSHIPHEADER H JOIN SOHEADER O
				ON H.ORDNBR = O.ORDNBR
				JOIN SOShipLine SL
				ON H.ShipperID = SL.ShipperID
				JOIN SOLINE OL
				ON SL.ORDNBR = OL.ORDNBR
				AND SL.OrdLineRef = OL.LineRef
			WHERE	H.SHIPPERID = @SHIPPERID
				AND H.INBATNBR = @BATNBR
				AND H.CPNYID = @CPNYID
				AND OL.LINEREF = SL.OrdLineRef
				AND H.INVCNBR = @INVCNBR
				AND SL.LineRef = @LINEREF
	END

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
 				 Parm00, Parm01, Parm02, Parm03, Parm04)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Order', @SQLErrNbr, 5,
				 @ShipperID, @BatNbr, @CPNYID, @LineRef, @InvcNbr)
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


