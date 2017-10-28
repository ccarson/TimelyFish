 CREATE Proc SOShipLot_ConsolidatedInv
        @CpnyID varchar(10),
	@InvcNbr varchar(15),
        @CustID varchar(15),
	@ShipToID varchar(10),
	@ShipViaID varchar(15),
        @ShipRegisterID varchar(10),
        @InvtID varchar(30),
        @OrdLineRef varchar(5),
        @CustOrdNbr varchar(25),
        @LotSerRef varchar(5)
AS
SELECT L.*
  FROM SOShipLine A INNER JOIN SOShipHeader B
                       On A.CpnyId = B.CpnyId AND A.ShipperId = B.ShipperId
		    INNER JOIN edsoshipheader E
                         ON B.cpnyid = E.cpnyid AND B.shipperid = E.shipperid
                    INNER JOIN SOShipLot L
                         ON A.CpnyID = L.CpnyID
                        AND A.ShipperID = L.ShipperID
                        AND A.LineRef = L.LineRef
	 WHERE B.CpnyID = @CpnyID AND B.InvcNbr = @InvcNbr
   AND B.Custid = @CustID AND B.ShipToID = @ShipToID
   AND B.ShipViaID = @ShipViaID AND B.ShipRegisterId = @ShipRegisterID
   AND B.CustOrdNbr = @CustOrdNbr
   AND A.InvtID = @InvtID AND A.OrdLineRef = @OrdLineRef
   AND B.EDI810 <> 0 AND E.lastedidate = '1/1/1900'
   AND B.Cancelled = 0 AND B.ConsolInv = 1
   AND A.QtyShip > 0
   AND L.LotSerRef LIKE @LotSerRef
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = B.CustId AND EDOutbound.Trans In ('810','880'))

ORDER BY L.LotSerNbr, L.ShipperID, L.LineRef, L.LotSerRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLot_ConsolidatedInv] TO [MSDSL]
    AS [dbo];

