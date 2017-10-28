 CREATE Proc EDCustomerEDI_ShipToTemplate @CustId varchar(15)
As
	Select CheckShipToId, MultiDestMeth, OutbndTemplate, SepDestOrd, S4Future09, S4Future03
	From CustomerEDI
	Where CustId = @CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCustomerEDI_ShipToTemplate] TO [MSDSL]
    AS [dbo];

