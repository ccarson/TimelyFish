 Create Proc EDSOShipLine_AllDMG @CpnyId varchar(10), @ShipperId varchar(15), @LineRef varchar(5) As
Select * From SOShipLine Where CpnyId = @CpnyId And ShipperId = @ShipperId And LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_AllDMG] TO [MSDSL]
    AS [dbo];

