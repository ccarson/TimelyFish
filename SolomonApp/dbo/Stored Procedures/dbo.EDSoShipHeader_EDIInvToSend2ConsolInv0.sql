 CREATE PROCEDURE EDSoShipHeader_EDIInvToSend2ConsolInv0  AS
SELECT soshipheader.*
  FROM soshipheader,edsoshipheader
 WHERE ltrim(rtrim(soshipheader.shipregisterid)) <> ''
   AND  EDI810 <> 0
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
    ON OBJECT::[dbo].[EDSoShipHeader_EDIInvToSend2ConsolInv0] TO [MSDSL]
    AS [dbo];

