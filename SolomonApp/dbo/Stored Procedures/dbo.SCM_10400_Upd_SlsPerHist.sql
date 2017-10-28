 CREATE	Procedure SCM_10400_Upd_SlsPerHist
		@CpnyID		VarChar(10),	/*  INTran.CpnyID  */
		@PerNbr		Char(6),	/*  INTran.PerPost  */
		@InvcNbr	VarChar(15),	/*  INTran.RefNbr  */
		@LineRef	Char(5),	/*  INTran.ARLineRef  */
		@Price		Float,		/*  INTran.TranAmt * INTran.InvtMult * -1  - Not from a costing transaction  */
		@Cost		Float,		/*  INTran.ExtCost * INTran.InvtMult * -1  -  Not from a costing transaction  */
		@LUpd_Prog	VarChar(8),
		@LUpd_User	VarChar(10),
		@BaseDecPl	SmallInt,
		@BMIDecPl 	SmallInt,
		@DecPlPrcCst 	SmallInt,
		@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@Period		smallint,
		    @FiscYr		Char(4)

	Select	@Period = cast(Right(@PerNbr, 2) as smallint), @FiscYr = Left(@PerNbr, 4)

	Update	SlsPerHist
		Set	PTDCOGS00 = Round(PTDCOGS00 + Case When @Period =  1
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS01 = Round(PTDCOGS01 + Case When @Period =  2
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS02 = Round(PTDCOGS02 + Case When @Period =  3
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS03 = Round(PTDCOGS03 + Case When @Period =  4
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS04 = Round(PTDCOGS04 + Case When @Period =  5
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS05 = Round(PTDCOGS05 + Case When @Period =  6
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS06 = Round(PTDCOGS06 + Case When @Period =  7
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS07 = Round(PTDCOGS07 + Case When @Period =  8
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS08 = Round(PTDCOGS08 + Case When @Period =  9
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS09 = Round(PTDCOGS09 + Case When @Period =  0
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS10 = Round(PTDCOGS10 + Case When @Period =  11
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS11 = Round(PTDCOGS11 + Case When @Period =  12
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			PTDCOGS12 = Round(PTDCOGS12 + Case When @Period =  13
				Then Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl) Else 0 End, @BaseDecPl),
			YTDCOGS = Round(YTDCOGS + Round((@Cost * SOShipLineSplit.S4Future03)/100, @BaseDecPl), @BaseDecPl),
			PTDSls00 = Round(PTDSls00 + Case When @Period =  1
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls01 = Round(PTDSls01 + Case When @Period =  2
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls02 = Round(PTDSls02 + Case When @Period =  3
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls03 = Round(PTDSls03 + Case When @Period =  4
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls04 = Round(PTDSls04 + Case When @Period =  5
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))

					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls05 = Round(PTDSls05 + Case When @Period =  6
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls06 = Round(PTDSls06 + Case When @Period =  7
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls07 = Round(PTDSls07 + Case When @Period =  8
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls08 = Round(PTDSls08 + Case When @Period =  9
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls09 = Round(PTDSls09 + Case When @Period =  10
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls10 = Round(PTDSls10 + Case When @Period =  11
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls11 = Round(PTDSls11 + Case When @Period =  12
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			PTDSls12 = Round(PTDSls12 + Case When @Period =  13
				Then (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100) Else 0 End, @BaseDecPl),
			YTDSls = Round(YTDSls + (@Price
					- @Price * (SOShipHeader.DiscPct/100))
					* (SOShipLineSplit.S4Future03/100), @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		 FROM   SOShipHeader (NoLock) Inner Join INTran (NoLock)
                        on SOShipHeader.InvcNbr = INTran.Refnbr inner join  SOShipLineSplit (NoLock)
                        on SOShipLineSplit.ShipperID = INTran.ShipperID
	         Left Join SlsPerHist On SlsPerHist.SlsPerID = SOShipLineSplit.SlsPerID
		WHERE   SOShipHeader.CpnyID = @CpnyID
			And SOShipHeader.InvcNbr = @InvcNbr
			And INTran.ARLineRef = @LineRef
			And SOShipLineSplit.S4Future03 <> 0
			And SlsPerHist.FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_SlsPerHist] TO [MSDSL]
    AS [dbo];

