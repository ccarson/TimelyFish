 CREATE Proc EDSOShipLine_LineSummary_ConsolidatedInv
        @CpnyID varchar(10),
	@InvcNbr varchar(15),
        @CustID varchar(15),
	@ShipToID varchar(10),
	@ShipViaID varchar(15),
        @ShipRegisterID varchar(10),
        @CustOrdNbr varchar(25)
AS
SELECT 	A.InvtID, A.OrdLineRef, A.OrdNbr, Sum(A.QtyShip) QtyShip
  FROM SOShipLine A INNER JOIN SOShipHeader B
                       On A.CpnyId = B.CpnyId AND A.ShipperId = B.ShipperId
		    INNER JOIN edsoshipheader E
                         ON B.cpnyid = E.cpnyid AND B.shipperid = E.shipperid
 WHERE B.CpnyID = @CpnyID
   AND B.InvcNbr = @InvcNbr
   AND B.Custid = @CustID
   AND B.ShipToID = @ShipToID
   AND B.ShipViaID = @ShipViaID
   AND B.ShipRegisterId = @ShipRegisterID
   AND B.CustOrdNbr = @CustOrdNbr
   AND B.EDI810 <> 0
   AND E.lastedidate = '1/1/1900'
   AND B.Cancelled = 0
   AND B.ConsolInv = 1
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = B.CustId AND EDOutbound.Trans In ('810','880'))
   AND A.QtyShip <> 0

 GROUP BY A.OrdLineRef, A.OrdNbr, A.InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_LineSummary_ConsolidatedInv] TO [MSDSL]
    AS [dbo];

