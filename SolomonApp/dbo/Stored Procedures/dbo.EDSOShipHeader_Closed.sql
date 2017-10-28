 CREATE Proc EDSOShipHeader_Closed @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From SOShipHeader Where CpnyId = @CpnyId And ShipperId Like @ShipperId
And Status = 'C' And Cancelled = 0 Order By CpnyId, ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_Closed] TO [MSDSL]
    AS [dbo];

