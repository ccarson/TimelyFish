 CREATE PROCEDURE EDSoShipHeader_EDIInvoicesToSend  @ShipRegisterId varchar(10) AS
--changed proc to use the ShipRegisterId field to process all invoices that have just been sent to AR
--The Sales Register program will launch the Invoice to EDI program in line so that we do not have to create an order step
--select soshipheader.* from soshipheader,edsoshipheader where soshipheader.invcnbr > '               ' and status = 'C' and EDI810 <> 0 and soshipheader.cpnyid = edsoshipheader.cpnyid and soshipheader.shipperid = edsoshipheader.shipperid and edsoshipheader.lastedidate = '1/1/1900'
select soshipheader.* from soshipheader,edsoshipheader where
soshipheader.ShipRegisterId = @ShipRegisterId and EDI810 <> 0 and
soshipheader.cpnyid = edsoshipheader.cpnyid and soshipheader.shipperid = edsoshipheader.shipperid
and edsoshipheader.lastedidate = '1/1/1900' And SOShipHeader.Cancelled = 0 And Exists (Select *
From EDOutbound Where EDOutbound.CustId = SOShipHeader.CustId And EDOutbound.Trans In ('810','880'))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSoShipHeader_EDIInvoicesToSend] TO [MSDSL]
    AS [dbo];

