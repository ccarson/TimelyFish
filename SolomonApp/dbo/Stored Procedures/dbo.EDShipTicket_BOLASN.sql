 CREATE Proc EDShipTicket_BOLASN @BOLNbr varchar(20) As
Select A.*,C.ConvMeth, C.Trans From EDShipTicket A Inner Join SOShipHeader B On A.CpnyId = B.CpnyId And
A.ShipperId = B.ShipperId Inner Join EDOutbound C On B.CustId = C.CustId Where A.BOLNbr = @BOLNbr
And C.Trans In ('856','857')


