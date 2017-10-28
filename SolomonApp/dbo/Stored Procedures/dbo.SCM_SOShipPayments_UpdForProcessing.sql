 Create	Procedure SCM_SOShipPayments_UpdForProcessing
	@CpnyID 	varchar(10),
	@ShipperID	varchar(15),
	@ShipRegisterID varchar(10),
	@OrigDocType	varchar(2)

as

	UPDATE 	SOShipPayments
	Set	S4Future11 = @ShipRegisterID,
		S4Future12 = @OrigDocType
	FROM	SOShipPayments
	Where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID


