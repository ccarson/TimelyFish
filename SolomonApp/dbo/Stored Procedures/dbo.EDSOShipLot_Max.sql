 CREATE PROCEDURE EDSOShipLot_Max @CpnyId varchar(10), @ShipperId varchar(15), @LineRef varchar(5) As
Select Max(LotSerRef) From SOShipLot Where Cpnyid = @CpnyId And ShipperId = @ShipperId And
LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLot_Max] TO [MSDSL]
    AS [dbo];

