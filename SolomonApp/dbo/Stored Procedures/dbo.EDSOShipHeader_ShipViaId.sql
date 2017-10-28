 CREATE Proc EDSOShipHeader_ShipViaId @CpnyId varchar(10), @ShipperId varchar(15) As
Select CpnyId, ShipperId, ShipViaId From SOShipHeader Where CpnyId = @CpnyId And ShipperId = @ShipperId And
Cancelled = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_ShipViaId] TO [MSDSL]
    AS [dbo];

