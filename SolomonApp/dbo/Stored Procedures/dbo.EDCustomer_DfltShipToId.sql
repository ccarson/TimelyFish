 Create Proc EDCustomer_DfltShipToId @Parm1 varchar(15) As Select DfltShipToId From Customer
Where CustId = @Parm1


