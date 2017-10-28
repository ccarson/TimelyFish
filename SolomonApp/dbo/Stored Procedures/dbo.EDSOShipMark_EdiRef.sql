 CREATE Proc EDSOShipMark_EdiRef @CpnyId varchar(10), @ShipperId varchar(15) As
Select A.Addr1, A.Addr2, A.Name1, A.Name2, A.Name3, A.City, A.State, A.Zip, A.Country, A.MarkForId,
A.Attn, B.EDIShipToRef From SOShipMark A Left Outer Join EDSTCustomer B On A.CustId = B.CustId
And A.MarkForId = B.ShipToId Where A.CpnyId = @CpnyId And A.ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipMark_EdiRef] TO [MSDSL]
    AS [dbo];

