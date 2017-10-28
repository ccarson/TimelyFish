 CREATE Proc EDSOShipHeader_ClosedNav @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From SOShipHeader Where CpnyId Like @CpnyId And ShipperId Like @ShipperId And
Status = 'C' Order By ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_ClosedNav] TO [MSDSL]
    AS [dbo];

