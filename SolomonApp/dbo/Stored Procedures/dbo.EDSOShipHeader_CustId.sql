 Create Proc EDSOShipHeader_CustId @CpnyId varchar(10), @ShipperID varchar(15) As
Select CustId From SOShipHeader Where CpnyId = @CpnyId And ShipperID = @ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_CustId] TO [MSDSL]
    AS [dbo];

