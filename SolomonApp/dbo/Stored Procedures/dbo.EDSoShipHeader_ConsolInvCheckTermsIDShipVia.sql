 CREATE PROCEDURE EDSoShipHeader_ConsolInvCheckTermsIDShipVia @CustOrdNbr VarChar(25), @SiteID VarChar(10), @Custid Varchar(15), @ShipRegisterID VarChar(10),
        @InvcNbr VarChar(15), @ShipperID VarChar(15), @TermsID VarChar(2), @ShipViaID VarChar(15), @CpnyID VarChar(10)
AS

-- All Consolidated Invoices must have the Same Terms ID and Ship Via ID. Write to EventLog if either one is not True.
SELECT ShipperID,CpnyID,TermsID,ShipViaID,CustOrdNbr
  FROM SOShipHeader
 WHERE CustOrdNbr = @CustOrdNbr
   AND SiteID = @SiteID
   AND Custid = @CustID
   AND CpnyID = @CpnyID
   AND ShipRegisterID = @ShipRegisterID
   --AND ShipperID <> @ShipperID
   AND ConsolInv = 1 AND  EDI810 <> 0
   AND Cancelled = 0
   AND (TermsID <> @TermsID OR ShipViaID <> @ShipViaID)
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = SOShipHeader.CustId AND EDOutbound.Trans In ('810','880'))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSoShipHeader_ConsolInvCheckTermsIDShipVia] TO [MSDSL]
    AS [dbo];

