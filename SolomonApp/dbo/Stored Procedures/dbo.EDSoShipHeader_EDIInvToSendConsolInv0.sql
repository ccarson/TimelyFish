 CREATE PROCEDURE EDSoShipHeader_EDIInvToSendConsolInv0  @ShipRegisterId varchar(10) AS
--changed proc to use the ShipRegisterId field to process all invoices that have just been sent to AR
--The Sales Register program will launch the Invoice to EDI program in line so that we do not have to create an order step
--select soshipheader.* from soshipheader,edsoshipheader where soshipheader.invcnbr > '               ' and status = 'C' and EDI810 <> 0 and soshipheader.cpnyid = edsoshipheader.cpnyid and soshipheader.shipperid = edsoshipheader.shipperid and edsoshipheader.lastedidate = '1/1/1900'
SELECT soshipheader.*
  FROM soshipheader,edsoshipheader
 WHERE soshipheader.ShipRegisterId = @ShipRegisterId
   AND EDI810 <> 0
   AND soshipheader.cpnyid = edsoshipheader.cpnyid
   AND soshipheader.shipperid = edsoshipheader.shipperid
   AND edsoshipheader.lastedidate = '1/1/1900'
   AND SOShipHeader.Cancelled = 0
   AND soshipheader.ConsolInv = 0
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = SOShipHeader.CustId AND EDOutbound.Trans In ('810','880'))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSoShipHeader_EDIInvToSendConsolInv0] TO [MSDSL]
    AS [dbo];

