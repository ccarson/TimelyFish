 Create	Procedure OU_SOSched_No_POAlloc
	@CpnyID		VarChar(10),
	@OrdNbr		VarChar(15)
As
	Select	*
		From	SOSched (NoLock)
		Where	CpnyID = @CpnyID
			And OrdNbr = @OrdNbr
			And AutoPO = 1 AND
			NOT EXISTS	(SELECT * FROM POAlloc
					 WHERE 	POAlloc.SOOrdNbr = SOSched.OrdNbr AND
						POAlloc.SOLineRef = SOSched.LineRef AND
						POAlloc.SOSchedRef = SOSched.SchedRef)

		ORDER BY AutoPOVendID, DropShip, ShipViaID,
			 ShipCustID, ShiptoID, ShipSiteID,
			 ShipVendID, S4Future11, ShipAddrID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[OU_SOSched_No_POAlloc] TO [MSDSL]
    AS [dbo];

