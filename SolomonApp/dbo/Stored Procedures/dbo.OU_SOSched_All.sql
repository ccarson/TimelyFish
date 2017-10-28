 Create	Procedure OU_SOSched_All
	@CpnyID		VarChar(10),
	@OrdNbr		VarChar(15)
As
	Select	*
		From	SOSched (NoLock)
		Where	CpnyID = @CpnyID
			And OrdNbr = @OrdNbr
			And AutoPO = 1
		ORDER BY AutoPOVendID, DropShip, ShipViaID,
			 ShipCustID, ShiptoID, ShipSiteID,
			 ShipVendID, S4Future11, ShipAddrID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[OU_SOSched_All] TO [MSDSL]
    AS [dbo];

