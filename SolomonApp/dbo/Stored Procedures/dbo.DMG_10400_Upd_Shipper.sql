 CREATE PROCEDURE DMG_10400_Upd_Shipper
	@SHIPPERID	VARCHAR(15),
	@BATNBR		VARCHAR(10),
	@CPNYID		VARCHAR(10),
	@LINEREF	VARCHAR(5),
	@INVCNBR	VARCHAR(15),
	@ProcessName	Varchar(8),
	@UserName	Varchar(10),
	@UserAddress	Varchar(21),
	@DECPLPRCCST	SmallInt,
	@BASEDECPL	SmallInt,
	@BMIDECPL	SmallInt
As
	Set NoCount On
	/*
	This procedure will update the cost on the shipper line.

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
	SET	@COST = 0
	Declare @TotCost	FLOAT
	SET	@TotCost = 0

	IF	EXISTS(SELECT H.SHIPPERID,   H.CuryMultDiv, H.CuryRate, L.UnitMultDiv, L.CnvFact
				FROM	SOSHIPHEADER H JOIN SOSHIPLINE L
					ON H.CpnyID = L.CpnyID
					And H.SHIPPERID = L.SHIPPERID

				WHERE	H.SHIPPERID = @SHIPPERID
					AND H.INBATNBR = @BATNBR
					AND H.CPNYID = @CPNYID
					AND L.LINEREF = @LINEREF
					AND (H.INVCNBR = RTRIM(@INVCNBR) OR H.SHIPPERID = RTRIM(@INVCNBR)))
	BEGIN
		Select	@COST = COALESCE(Round(Sum(ExtCost) / Sum(Case When UnitMultDiv = 'D' Then Qty / CnvFact Else Qty * CnvFact End), @DECPLPRCCST), 0),
			@TotCost = Round(Sum(-InvtMult*ExtCost), @BASEDECPL)
			FROM	INTRAN
			WHERE	BATNBR = @BATNBR
				AND CPNYID = @CPNYID
				AND REFNBR = @INVCNBR
                AND SHIPPERID = @SHIPPERID
				AND SHIPPERLINEREF = @LINEREF
				AND TRANTYPE NOT IN ('CT', 'CG')
			GROUP BY BATNBR, CPNYID, REFNBR, SHIPPERID, SHIPPERLINEREF
			/*	Problem is this is the stocking UOM cost - next we need to convert to Selling UOM Cost	*/

		UPDATE	L
 			SET	L.COST	=   ROUND(Case When L.UnitMultDiv = 'D' Then @cost / L.CnvFact Else @cost * L.CnvFact End, @DECPLPRCCST),
				L.TotCost = (@TotCost),
				L.CURYCOST =     ROUND(Case When H.CuryMultDiv = 'D' Then ROUND(Case When L.UnitMultDiv = 'D' Then @cost / L.CnvFact Else @cost * L.CnvFact End, @DECPLPRCCST) * H.CuryRate Else ROUND(Case When L.UnitMultDiv = 'D' Then @cost / L.CnvFact Else @cost * L.
CnvFact End, @DECPLPRCCST) / H.CuryRate End, @DECPLPRCCST),
				L.CURYTOTCOST =  ROUND(Case When H.CuryMultDiv = 'D' Then @TotCost * H.CuryRate Else @TotCost / H.CuryRate End, c.DecPl),
				L.LUpd_DateTime = Convert(SmallDateTime, GetDate()),
				L.LUpd_Prog = @ProcessName,
				L.LUpd_User = @UserName
				FROM	SOSHIPHEADER H JOIN SOSHIPLINE L
					ON H.CpnyID = L.CpnyID
					And H.SHIPPERID = L.SHIPPERID
					JOIN Currncy c (NOLOCK)
					ON c.curyID = H.CuryID
				WHERE	H.SHIPPERID = @SHIPPERID
					AND H.INBATNBR = @BATNBR
					AND H.CPNYID = @CPNYID
					AND L.LINEREF = @LINEREF
					AND (H.INVCNBR = RTRIM(@INVCNBR) OR H.SHIPPERID = RTRIM(@INVCNBR))

		UPDATE	H
			SET	H.TotCost = V.TotCost,
				H.LUpd_DateTime = CONVERT(smalldatetime, getdate()),
				H.LUpd_Prog = @ProcessName,
				H.LUpd_User = @UserName
				FROM	SOShipHeader H
				INNER 	JOIN (SELECT CpnyID, ShipperID, TotCost = SUM(TotCost) FROM SOShipLine GROUP BY CpnyID, ShipperID) V ON V.CpnyID = H.CpnyID AND V.ShipperID = H.ShipperID
				WHERE	H.CpnyID = @CpnyID AND
					H.ShipperID = @ShipperID

	/*
	NOTE:	This will have to be modified when the specific cost identification is directly
		tied to lots and serial numbers.
	*/
	END

	Select @SQLErrNbr = @@Error
	If @SQLErrNbr <> 0
	Begin
		Insert 	Into IN10400_RETURN
				(BatNbr, ComputerName, S4Future01, SQLErrorNbr, ParmCnt,
 				 Parm00, Parm01, Parm02, Parm03, Parm04,
				Parm05)
			Values
				(@BatNbr, @UserAddress, 'DMG_10400_Upd_Shipper', @SQLErrNbr, 6,
				 @ShipperID, @BatNbr, @CPNYID, @LineRef, @InvcNbr, '')
		Goto Abort
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_Upd_Shipper] TO [MSDSL]
    AS [dbo];

