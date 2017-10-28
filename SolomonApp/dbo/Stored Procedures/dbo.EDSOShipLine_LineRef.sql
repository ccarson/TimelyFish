 CREATE Proc EDSOShipLine_LineRef @CpnyId varchar(10), @ShipperId varchar(15), @LineRef varchar(5) As
Select * From SOShipLine Where CpnyID = @CpnyId And ShipperId = @ShipperId And LineRef Like @LineRef
Order By CpnyID, ShipperID, LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_LineRef] TO [MSDSL]
    AS [dbo];

