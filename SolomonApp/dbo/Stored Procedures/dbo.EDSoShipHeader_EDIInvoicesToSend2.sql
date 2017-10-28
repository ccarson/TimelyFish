 CREATE PROCEDURE EDSoShipHeader_EDIInvoicesToSend2  AS
select soshipheader.* from soshipheader,edsoshipheader
where ltrim(rtrim(soshipheader.shipregisterid)) <> ''
and  EDI810 <> 0
and soshipheader.cpnyid = edsoshipheader.cpnyid
and soshipheader.shipperid = edsoshipheader.shipperid
and edsoshipheader.lastedidate = '1/1/1900'
And SOShipHeader.Cancelled = 0 And Exists (Select * From EDOutbound Where EDOutbound.CustId =
SOShipHeader.CustId And EDOutbound.Trans In ('810','880'))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSoShipHeader_EDIInvoicesToSend2] TO [MSDSL]
    AS [dbo];

