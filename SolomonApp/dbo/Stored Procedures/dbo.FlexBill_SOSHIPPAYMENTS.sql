 create proc FlexBill_SOSHIPPAYMENTS
	 @CpnyID  varchar(10),  
     @ShipperID varchar(15)  
as
	SELECT	SP.CardNbr,
            PM.CashAcct,
            PM.CashSub,
            SP.CpnyID,
            SP.ChkNbr,
            SP.CuryPmtAmt,
            SP.PmtAmt,
            SP.PmtTypeID,
            SP.S4Future01,
            SP.ShipperID

	 FROM	SOShipPayments SP JOIN PmtType PM
                                on	PM.CpnyID = SP.CpnyID
                               and	PM.PmtTypeID = SP.PmtTypeID
	WHERE	SP.CpnyID = @CpnyID
	  and	SP.ShipperID = @ShipperID
	Order by SP.CpnyID, PM.CashAcct, PM.CashSub, SP.ShipperID


