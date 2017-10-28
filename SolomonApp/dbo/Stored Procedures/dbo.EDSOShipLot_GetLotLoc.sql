 Create Proc EDSOShipLot_GetLotLoc @CpnyId varchar(10), @ShipperId varchar(15), @LineRef varchar(5), @LotSerRef varchar(5) As
Select LotSerNbr, WhseLoc From SOShipLot Where CpnyId = @CpnyId And ShipperId = @ShipperId And
LineRef = @LineRef And LotSerRef = @LotSerRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLot_GetLotLoc] TO [MSDSL]
    AS [dbo];

