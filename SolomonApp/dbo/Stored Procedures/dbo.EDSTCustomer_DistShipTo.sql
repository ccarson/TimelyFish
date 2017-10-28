 Create Proc EDSTCustomer_DistShipTo @CustId varchar(15), @ShipToId varchar(10) As
Select DistCenterShipToId From EDSTCustomer Where CustId = @CustId And ShipToId = @ShipToId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSTCustomer_DistShipTo] TO [MSDSL]
    AS [dbo];

