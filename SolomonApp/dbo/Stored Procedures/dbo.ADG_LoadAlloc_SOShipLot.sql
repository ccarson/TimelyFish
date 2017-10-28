 Create Proc ADG_LoadAlloc_SOShipLot
	@CpnyID		Varchar(10),
	@ShipperID	Varchar(15)
As

SELECT	LineRef, InvtID, Space(10), WhseLoc, LotSerNbr,
	QtyShip, S4Future03, LEFT(S4Future11,1)
	FROM	SOShipLot (NOLOCK)
	WHERE	CpnyID = @CpnyID
		AND ShipperID = @ShipperID
		AND QtyShip > 0


