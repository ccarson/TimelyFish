 Create Proc EDSOShipLot_Count @CpnyId varchar(10), @ShipperId varchar(15), @LineRef varchar(5) As
Select Count(*) From SOShipLot Where CpnyId = @CpnyId And ShipperId = @ShipperId And LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLot_Count] TO [MSDSL]
    AS [dbo];

