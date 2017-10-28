 CREATE Proc EDSTCustomer_ShipToIdDMG @Parm1 varchar(15), @Parm2 varchar(17) As
Select A.ShipToId From EDSTCustomer A Inner Join SOAddress B On A.CustId = B.CustId And A.ShipToId =
B.ShipToId Where A.CustId = @Parm1 And A.EDIShipToRef = @Parm2


