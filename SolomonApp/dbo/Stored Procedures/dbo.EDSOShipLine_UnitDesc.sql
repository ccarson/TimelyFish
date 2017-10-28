 CREATE Proc EDSOShipLine_UnitDesc @CpnyId varchar(10), @ShipperId varchar(15), @LineRef varchar(5) As
Select LineRef, UnitDesc From SOShipLine Where CpnyId = @CpnyId And ShipperId = @ShipperId And LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_UnitDesc] TO [MSDSL]
    AS [dbo];

