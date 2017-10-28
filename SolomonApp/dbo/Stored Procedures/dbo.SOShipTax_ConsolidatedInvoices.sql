 CREATE PROCEDURE SOShipTax_ConsolidatedInvoices
	@CpnyID varchar(10),
	@InvcNbr varchar(15),
        @Custid varchar(15),
	@TaxID varchar(10),
	@TaxCat varchar(10),
        @ShipRegisterId varchar(10),
        @CustOrdNbr varchar(25),
	@ShipToID varchar(10),
	@ShipViaID varchar(15)
AS
SELECT s.CpnyID, Min(s.Crtd_DateTime) Crtd_DateTime, Min(s.Crtd_Prog) Crtd_Prog, Min(s.Crtd_User) Crtd_User,
       Sum(s.CuryFrtTax) CuryFrtTax, Sum(s.CuryFrtTxbl) CuryFrtTxbl, Sum(s.CuryMerchTax) CuryMerchTax,
       Sum(s.CuryMerchTxbl) CuryMerchTxbl, Sum(s.CuryMerchTxblLessTax) CuryMerchTxblLessTax,
       Sum(s.CuryMiscTax) CuryMiscTax, Sum(s.CuryMiscTxbl) CuryMiscTxbl, Sum(s.CuryTotTax) CuryTotTax,
       Sum(s.CuryTotTxbl) CuryTotTxbl, Sum(s.FrtTax) Sum, Min(s.FrtTxbl) FrtTxbl, Min(s.LUpd_DateTime) LUpd_DateTime,
       Min(s.LUpd_Prog) LUpd_Prog, Min(s.LUpd_User) LUpd_User, Min(s.MerchTax) MerchTax, Min(s.MerchTxbl) MerchTxbl,
       Sum(s.MerchTxblLessTax) MerchTxblLessTax, Sum(s.MiscTax) MiscTax, Sum(s.MiscTxbl) MiscTxbl, Min(s.NoteID) NoteID,
       Min(s.S4Future01) S4Future01, Min(s.S4Future02) S4Future02, Min(s.S4Future03) S4Future03,
       Min(s.S4Future04) S4Future04, Min(s.S4Future05) S4Future05, Min(s.S4Future06) S4Future06,
       Min(s.S4Future07) S4Future07, Min(s.S4Future08) S4Future08, Min(s.S4Future09) S4Future09,
       Min(s.S4Future10) S4Future10, Min(s.S4Future11) S4Future11, Min(s.S4Future12) S4Future12,
       Min(s.ShipperID) ShipperID, Min(s.ShowTaxOnOrderTotal) ShowTaxOnOrderTotal,
       s.TaxCat, s.TaxID, Min(s.TaxRate) TaxRate, Sum(s.TotTax) TotTax, Sum(s.TotTxbl) TotTxbl,
       Min(s.User1) User1, Min(s.User10) User10, Min(s.User2) User2, Min(s.User3) User3, Min(s.User4) User4,
       Min(s.User5) User5, Min(s.User6) User6, Min(s.User7) User7, Min(s.User8) User8, Min(s.User9) User9, Min(s.tstamp)tstamp
  FROM SOShipHeader h INNER JOIN SOShipTax s
                         ON h.ShipperID = s.ShipperID
                        AND h.CpnyID = s.CpnyID
                      INNER JOIN edsoshipheader e
                         ON h.cpnyid = e.cpnyid
                        AND h.shipperid = e.shipperid

 WHERE s.CpnyID = @CpnyID
   AND h.InvcNbr = @InvcNbr
   AND h.Custid = @Custid
   AND s.TaxID LIKE @TaxID
   AND s.TaxCat LIKE @TaxCat
   AND h.ShipRegisterId = @ShipRegisterId
   AND h.CustOrdNbr = @CustOrdNbr
   AND h.ShipToID = @ShipToID
   AND h.ShipViaID = @ShipViaID
   AND h.EDI810 <> 0
   AND e.lastedidate = '1/1/1900'
   AND h.Cancelled = 0
   AND h.ConsolInv = 1
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = h.CustId AND EDOutbound.Trans In ('810','880'))
Group by s.CpnyID, s.TaxID, s.TaxCat



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipTax_ConsolidatedInvoices] TO [MSDSL]
    AS [dbo];

