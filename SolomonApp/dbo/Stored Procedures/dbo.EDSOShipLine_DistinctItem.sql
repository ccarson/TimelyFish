 CREATE Proc EDSOShipLine_DistinctItem @CpnyId varchar(10), @ShipperId varchar(15) As
Select Distinct InvtId From SOShipLine Where CpnyId = @CpnyId And ShipperId = @ShipperId
Order By InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_DistinctItem] TO [MSDSL]
    AS [dbo];

