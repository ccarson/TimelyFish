 CREATE PROCEDURE EDSOShipHeader_ConsolidatedInvoices
	@ShipperID varchar(15),
	@CpnyID varchar(10),
        @InvcNbr varchar(15),
	@CustID varchar(15),
        @ShipRegisterId varchar(10),
        @CustOrdNbr varchar(25),
	@ShipToID varchar(10),
	@ShipViaID varchar(15)
AS
SELECT MIN(e.BOL) BOL, MIN(e.CpnyId) CpnyId, MIN(e.Crtd_DateTime) Crtd_DateTime,
       MIN(e.Crtd_Prog) Crtd_Prog, MIN(e.Crtd_User) Crtd_User, MIN(e.Height) Height, MIN(e.HeightUOM) HeightUOM,
       MIN(e.LastEDIDate) LastEDIDate, MIN(e.Len) Len, MIN(e.LenUOM) LenUOM, MIN(e.Lupd_DateTime) Lupd_DateTime,
       MIN(e.Lupd_Prog) Lupd_Prog, MIN(e.Lupd_User) Lupd_User, MIN(e.OutboundProcNbr) OutboundProcNbr,
       MIN(e.S4Future01) S4Future01, MIN(e.S4Future02) S4Future02, MIN(e.S4Future03) S4Future03,
       MIN(e.S4Future04) S4Future04, MIN(e.S4Future05) S4Future05, MIN(e.S4Future06) S4Future06,
       MIN(e.S4Future07) S4Future07, MIN(e.S4Future08) S4Future08, MIN(e.S4Future09) S4Future09,
       MIN(e.S4Future10) S4Future10, MIN(e.S4Future11) S4Future11, MIN(e.S4Future12) S4Future12,
       MIN(e.SendViaEDI) SendViaEDI, MIN(e.ShipperId) ShipperId, MIN(e.User1) User1, MIN(e.User10) User10,
       MIN(e.User2) User2, MIN(e.User3) User3, MIN(e.User4) User4, MIN(e.User5) User5, MIN(e.User6) User6,
       MIN(e.User7) User7, MIN(e.User8) User8, MIN(e.User9) User9, Sum(eg.Volume) Volume, MIN(e.VolumeUOM) VolumeUOM,
       Sum(eg.Weight) Weight, MIN(e.WeightUOM) WeightUOM, MIN(e.Width) Width, MIN(e.WidthUOM) WidthUOM, MIN(e.tstamp) tstamp
  FROM soshipheader s INNER JOIN edsoshipheader e
                         ON e.cpnyid = @CpnyID
                        AND  e.shipperid = @ShipperID
                      INNER JOIN edsoshipheader eg
                         ON eg.cpnyid = s.cpnyid
                        AND eg.shipperid = s.shipperid
 WHERE s.ShipRegisterId = @ShipRegisterId
   AND s.InvcNbr = @InvcNbr
   AND s.Custid = @CustID
   AND s.CpnyID = @CpnyID
   AND s.CustOrdNbr = @CustOrdNbr
   AND s.ShipToID = @ShipToID
   AND s.ShipViaID = @ShipViaID
   AND s.EDI810 <> 0
   AND eg.lastedidate = '1/1/1900'
   AND s.Cancelled = 0
   AND s.ConsolInv = 1
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = s.CustId
                  AND EDOutbound.Trans In ('810','880'))
Group by eg.CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_ConsolidatedInvoices] TO [MSDSL]
    AS [dbo];

