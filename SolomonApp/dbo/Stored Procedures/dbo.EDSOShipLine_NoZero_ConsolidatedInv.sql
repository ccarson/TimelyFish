 CREATE Proc EDSOShipLine_NoZero_ConsolidatedInv
        @CpnyID varchar(10),
	@InvcNbr varchar(15),
        @CustID varchar(15),
	@ShipToID varchar(10),
	@ShipViaID varchar(15),
        @ShipRegisterID varchar(10),
        @CustOrdNbr varchar(25)
AS
SELECT 	Min(A.AlternateID) AlternateID, Min(A.AltIDType) AltIDType, Min(A.AvgCost) AvgCost,
	Min(A.BMICost) BMICost, Min(A.BMICuryID) BMICuryID, Min(A.BMIEffDate) BMIEffDate,
	Min(A.BMIExtPriceInvc) BMIExtPriceInvc, Min(A.BMIMultDiv) BMIMultDiv, Min(A.BMIRate) BMIRate,
	Min(A.BMIRtTp) BMIRtTp, Min(A.BMISlsPrice) BMISlsPrice, Min(A.ChainDisc) ChainDisc,
	Min(A.CmmnPct) CmmnPct, Min(A.CnvFact) CnvFact, Min(A.COGSAcct) COGSAcct,
	Min(A.COGSSub) COGSSub, Sum(A.CommCost) CommCost, Sum(A.Cost) Cost,
	A.CpnyID, Min(A.Crtd_DateTime) Crtd_DateTime, Min(A.Crtd_Prog) Crtd_Prog,
	Min(A.Crtd_User) Crtd_User, Sum(A.CuryCommCost) CuryCommCost, Sum(A.CuryCost) CuryCost,
	Min(A.CuryListPrice) CuryListPrice, Min(A.CurySlsPrice) CurySlsPrice, Sum(A.CuryTaxAmt00) CuryTaxAmt00,
	Sum(A.CuryTaxAmt01) CuryTaxAmt01, Sum(A.CuryTaxAmt02) CuryTaxAmt02, Sum(A.CuryTaxAmt03) CuryTaxAmt03,
	Sum(A.CuryTotCommCost) CuryTotCommCost, Sum(A.CuryTotCost) CuryTotCost, Sum(A.CuryTotInvc) CuryTotInvc,
	Sum(A.CuryTotMerch) CuryTotMerch, Sum(A.CuryTxblAmt00) CuryTxblAmt00, Sum(A.CuryTxblAmt01) CuryTxblAmt01,
	Sum(A.CuryTxblAmt02) CuryTxblAmt02, Sum(A.CuryTxblAmt03) CuryTxblAmt03, Min(A.Descr) Descr,
	Min(A.DescrLang) DescrLang, Min(A.DiscAcct) DiscAcct, Min(A.DiscPct) DiscPct,
	Min(A.DiscSub) DiscSub, Min(A.Disp) Disp, Min(A.InspID) InspID,
	Min(A.InspNoteID) InspNoteID, Min(A.InvAcct) InvAcct, Min(A.InvSub) InvSub,
	A.InvtID, Min(A.IRDemand) IRDemand, Min(A.IRInvtID) IRInvtID,
	Min(A.IRSiteID) IRSiteID, Min(A.ItemGLClassID) ItemGLClassID, Min(A.LineNbr) LineNbr,
	Min(A.LineRef) LineRef, Min(A.ListPrice) ListPrice, Min(A.LotSerCntr) LotSerCntr,
	Min(A.LUpd_DateTime) LUpd_DateTime, Min(A.LUpd_Prog) LUpd_Prog, Min(A.LUpd_User) LUpd_User,
	Min(A.ManualCost) ManualCost, Min(A.ManualPrice) ManualPrice, Min(A.NoteID) NoteID,
	A.OrdLineRef, A.OrdNbr, Min(A.OrigBO) OrigBO,
	Min(A.OrigINBatNbr) OrigINBatNbr, Min(A.OrigInvcNbr) OrigInvcNbr, Min(A.OrigInvtID) OrigInvtID,
	Min(A.OrigShipperID) OrigShipperID, Min(A.OrigShipperLineRef) OrigShipperLineRef, Min(A.ProjectID) ProjectID,
	Sum(A.QtyBO) QtyBO, Sum(A.QtyFuture) QtyFuture, Sum(A.QtyOrd) QtyOrd,
	Sum(A.QtyPick) QtyPick, Sum(A.QtyPrevShip) QtyPrevShip, Sum(A.QtyShip) QtyShip,
	Min(A.RebateID) RebateID, Min(A.RebatePer) RebatePer, Min(A.RebateRefNbr) RebateRefNbr,
	Min(A.S4Future01) S4Future01, Min(A.S4Future02) S4Future02, Min(A.S4Future03) S4Future03,
	Min(A.S4Future04) S4Future04, Min(A.S4Future05) S4Future05, Min(A.S4Future06) S4Future06,
	Min(A.S4Future07) S4Future07, Min(A.S4Future08) S4Future08, Min(A.S4Future09) S4Future09,
	Min(A.S4Future10) S4Future10, Min(A.S4Future11) S4Future11, Min(A.S4Future12) S4Future12,
	Min(A.Sample) Sample, Min(A.Service) Service, Min(A.ShipperID) ShipperID,
	Sum(A.ShipWght) ShipWght, Min(A.SiteID) SiteID, Min(A.SlsAcct) SlsAcct,
	Min(A.SlsperID) SlsperID, Min(A.SlsPrice) SlsPrice, Min(A.SlsPriceID) SlsPriceID,
	Min(A.SlsSub) SlsSub, Min(A.SplitLots) SplitLots, Min(A.Status) Status,
	Min(A.TaskID) TaskID, Min(A.Taxable) Taxable, Sum(A.TaxAmt00) TaxAmt00,
	Sum(A.TaxAmt01) TaxAmt01, Sum(A.TaxAmt02) TaxAmt02, Sum(A.TaxAmt03) TaxAmt03,
	Min(A.TaxCat) TaxCat, Min(A.TaxID00) TaxID00, Min(A.TaxID01) TaxID01,
	Min(A.TaxID02) TaxID02, Min(A.TaxID03) TaxID03, Min(A.TaxIDDflt) TaxIDDflt,
	Sum(A.TotCommCost) TotCommCost, Sum(A.TotCost) TotCost, Sum(A.TotInvc) TotInvc,
	Sum(A.TotMerch) TotMerch, Sum(A.TxblAmt00) TxblAmt00, Sum(A.TxblAmt01) TxblAmt01,
	Sum(A.TxblAmt02) TxblAmt02, Sum(A.TxblAmt03) TxblAmt03, Min(A.UnitDesc) UnitDesc,
	Min(A.UnitMultDiv) UnitMultDiv, Min(A.User1) User1, Min(A.User10) User10,
	Min(A.User2) User2, Min(A.User3) User3, Min(A.User4) User4,
	Min(A.User5) User5, Min(A.User6) User6, Min(A.User7) User7,
	Min(A.User8) User8, Min(A.User9) User9, Min(A.tstamp) tstamp,
	Min(C.SiteId) SiteId, Min(C.CurySlsPriceOrig) CurySlsPriceOrig, Min(D.Name) Name
  FROM SOShipLine A INNER JOIN SOShipHeader B
                       On A.CpnyId = B.CpnyId AND A.ShipperId = B.ShipperId
                    LEFT OUTER JOIN SOLine C
                       On B.CpnyId = C.CpnyId AND B.OrdNbr = C.OrdNbr AND A.OrdLineRef = C.LineRef
                    LEFT OUTER JOIN SalesPerson D
                       On B.SlsPerId = D.SlsPerId
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
 GROUP BY A.OrdLineRef, A.OrdNbr, A.InvtID, A.CpnyID
 ORDER BY A.OrdLineRef, A.OrdNbr, A.InvtID, A.CpnyId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_NoZero_ConsolidatedInv] TO [MSDSL]
    AS [dbo];

