 Create Proc EDSOShipHeader_SingleShipper @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From SOShipHeader Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_SingleShipper] TO [MSDSL]
    AS [dbo];

