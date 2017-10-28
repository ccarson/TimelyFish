 Create Proc EDSOShipLine_CountSum @CpnyId varchar(10), @ShipperId varchar(15) As
Select Count(*), Sum(QtyShip) From SOShipLine Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_CountSum] TO [MSDSL]
    AS [dbo];

