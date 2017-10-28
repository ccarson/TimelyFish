 CREATE PROCEDURE SOShipMisc_ConsolidatedInvoices
	@CpnyID varchar(10),
	@InvcNbr varchar(15),
        @CustID varchar(15),
	@ShipToID varchar(10),
	@ShipViaID varchar(15),
        @ShipRegisterID varchar(10),
        @CustOrdNbr varchar(25)
AS
SELECT  MIN(s.CpnyID) CpnyID, MIN(s.Crtd_DateTime) Crtd_DateTime, MIN(s.Crtd_Prog) Crtd_Prog, MIN(s.Crtd_User) Crtd_User,
        Sum(s.CuryMiscChrg) CuryMiscChrg, Max(s.Descr) Descr, MIN(s.LUpd_DateTime) LUpd_DateTime,
        MIN(s.LUpd_Prog) LUpd_Prog, MIN(s.LUpd_User) , MIN(s.MiscAcct) , Sum(s.MiscChrg) MiscChrg,
        MiscChrgID, MIN(s.MiscChrgRef) MiscChrgRef, MIN(s.MiscSub) MiscSub, MIN(s.NoteID) NoteID,
        MIN(s.S4Future01) S4Future01, MIN(s.S4Future02) S4Future02, Max(s.S4Future03) S4Future03, MIN(s.S4Future04) S4Future04,
        MIN(s.S4Future05) S4Future05, MIN(s.S4Future06) S4Future06, MIN(s.S4Future07) S4Future07, MIN(s.S4Future08) ,
        MIN(s.S4Future09) S4Future09, MIN(s.S4Future10) S4Future10, Max(s.S4Future11) S4Future11, MIN(s.S4Future12) S4Future12,
        MIN(s.Service) Service, MIN(s.ShipperID) ShipperID, MIN(s.Taxable) Taxable,
        MIN(s.TaxCat) TaxCat, MIN(s.User1) User1, MIN(s.User10) , MIN(s.User2) , MIN(s.User3) ,
        MIN(s.User4) User4, MIN(s.User5) User5, MIN(s.User6) User6, MIN(s.User7) User7,
        MIN(s.User8) User8, MIN(s.User9) User9, MIN(s.tstamp) tstamp
  FROM SOShipHeader h INNER JOIN SOShipMisc s
                         ON h.ShipperID = s.ShipperID
                        AND h.CpnyID = s.CpnyID
                      INNER JOIN edsoshipheader e
                         ON h.cpnyid = e.cpnyid
                        AND h.shipperid = e.shipperid

 WHERE h.CpnyID = @CpnyID
   AND h.InvcNbr = @InvcNbr
   AND h.Custid = @CustID
   AND h.ShipToID = @ShipToID
   AND h.ShipViaID = @ShipViaID
   AND h.ShipRegisterId = @ShipRegisterID
   AND h.EDI810 <> 0
   AND e.lastedidate = '1/1/1900'
   AND h.Cancelled = 0
   AND h.ConsolInv = 1
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = h.CustId AND EDOutbound.Trans In ('810','880'))
Group by s.MiscChrgID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipMisc_ConsolidatedInvoices] TO [MSDSL]
    AS [dbo];

