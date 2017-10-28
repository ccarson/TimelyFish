 create proc FLEXBILL_UPDTSHIP_SOSHIPPAYMENTS
	 @CpnyID  varchar(10),  
     @ShipperID varchar(15)  
as
	select	SP.CardNbr,
		PM.CashAcct,
		PM.CashSub,
		SP.CpnyID,
		SP.ChkNbr,
		SP.CuryPmtAmt,
		SH.CuryID,
		SP.NoteID,
		SH.PerPost,
		SP.PmtAmt,
		SP.PmtRef,
		SP.PmtTypeID,
		SP.S4Future01,
		SP.S4Future12,
		SP.ShipperID,
		PM.ValidationType,
        SP.PmtDate

	from	SOShipPayments SP
	join	SOShipHeader SH
	  on	SH.CpnyID = SP.CpnyID
	  and	SH.ShipperID = SP.ShipperID
	join	PmtType PM
	  on	PM.CpnyID = SP.CpnyID
	  and	PM.PmtTypeID = SP.PmtTypeID
	where	SP.CpnyID = @CpnyID
	  and	SP.ShipperID = @ShipperID
	Order by SP.CpnyID, SH.CuryID, SH.PerPost, PM.CashAcct, PM.CashSub, SP.ShipperID


