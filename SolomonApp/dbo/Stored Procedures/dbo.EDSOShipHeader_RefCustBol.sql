 CREATE PROCEDURE EDSOShipHeader_RefCustBol @BolNbr varchar(20) AS
Select C.BOLRptFormat From SOShipHeader A, EDShipTicket B, customeredi C Where A.ShipperID = B.ShipperID And C.CustId = A.CustId And B.BolNbr = @BolNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_RefCustBol] TO [MSDSL]
    AS [dbo];

