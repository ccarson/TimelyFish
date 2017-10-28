 Create	Procedure SCM_10400_Upd_ARTran
	@CustID		VarChar(15),
	@CpnyID		VarChar(10),
	@ShipperID	VarChar(15),
	@ShipperLineRef	VarChar(5),
	@ExtCost	Float,
	@INTranType	VarChar(2),
	@LUpd_Prog      VarChar(10),
	@LUpd_User      VarChar(8),
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt
As
	Update	ARTran
		Set	--All ARTrans have the same TranType as the ARDoc, but
			--OM Docs can have lines with different TranTypes than the Shipper/SO
			--So, when the IN TranType <> AR TranType, the Qty, ExtCost and CuryExtCost
			--should be multiplied by -1
			Qty = Case When TranType = @INTranType Or TranType = 'AD' Then Qty Else Qty * -1 End,
			ExtCost = Case When TranClass In('D','M') Then 0.00 Else Round(ExtCost + @ExtCost, @BaseDecPl) * (Case When TranType = @INTranType Or TranType = 'AD' Then 1 Else -1 End) End,
			CuryExtCost = Case When TranClass in('D','M') Then 0.00 Else Round(CuryExtCost + (Case When CuryMultDiv = 'D' Then @ExtCost * CuryRate Else @ExtCost / CuryRate end), @BMIDecPl) * (Case When TranType = @INTranType Or TranType = 'AD' Then 1 Else -1 End)End,
			S4Future09 = 1,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	CustID = @CustID
			And ShipperCpnyID = @CpnyID
			And ShipperID = @ShipperID
			And ShipperLineRef = @ShipperLineRef




GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_ARTran] TO [MSDSL]
    AS [dbo];

