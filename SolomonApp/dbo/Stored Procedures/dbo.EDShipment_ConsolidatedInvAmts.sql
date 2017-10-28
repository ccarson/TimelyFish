 CREATE PROCEDURE EDShipment_ConsolidatedInvAmts
        @CpnyID varchar(10),
        @InvcNbr varchar(15),
	@CustID varchar(15),
	@ShipToID varchar(10),
	@ShipViaID varchar(15),
        @ShipRegisterId varchar(10),
        @CustOrdNbr varchar(25)
AS
SELECT sum(m.NbrContainer) NbrContainer, sum(m.CuryCODCharge) CuryCODCharge
  FROM soshipheader s INNER JOIN edsoshipheader e
                         ON s.cpnyid = e.cpnyid
                        AND s.shipperid = e.shipperid
                      INNER JOIN EDShipTicket t
                         ON t.ShipperID = s.ShipperID
                        AND t.CpnyID = s.CpnyID
                      INNER JOIN EDShipment m
                       ON t.BOLNbr = m.BOLNbr
 WHERE s.ShipRegisterId = @ShipRegisterId
   AND s.InvcNbr = @InvcNbr
   AND s.Custid = @Custid
   AND s.CpnyID = @CpnyID
   AND s.CustOrdNbr = @CustOrdNbr
   AND s.ShipToID = @ShipToID
   AND s.ShipViaID = @ShipViaID
   AND EDI810 <> 0
   AND e.lastedidate = '1/1/1900'
   AND s.Cancelled = 0
   AND s.ConSolInv = 1
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = s.CustId
                  AND EDOutbound.Trans In ('810','880'))
Group by s.CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_ConsolidatedInvAmts] TO [MSDSL]
    AS [dbo];

