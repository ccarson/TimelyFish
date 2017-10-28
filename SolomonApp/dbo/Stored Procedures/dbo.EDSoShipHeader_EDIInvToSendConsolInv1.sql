 CREATE PROCEDURE EDSoShipHeader_EDIInvToSendConsolInv1  @ShipRegisterId varchar(10) AS
--changed proc to use the ShipRegisterId field to process all invoices that have just been sent to AR
--The Sales Register program will launch the Invoice to EDI program in line so that we do not have to create an order step
--select soshipheader.* from soshipheader,edsoshipheader where soshipheader.invcnbr > '               ' and status = 'C' and EDI810 <> 0 and soshipheader.cpnyid = edsoshipheader.cpnyid and soshipheader.shipperid = edsoshipheader.shipperid and edsoshipheader.lastedidate = '1/1/1900'

--SHOULD THINK ABOUT ADDING CPNYID TO GROUP BY.
Select MIN(s.AccrDocDate) AccrDocDate, MIN(s.AccrPerPost) AccrPerPost, MIN(s.AccrRevAcct) AccrRevAcct,
       MIN(s.AccrRevSub) AccrRevSub, MIN(s.AccrShipRegisterID) AccrShipRegisterID,
       MIN(s.AddressType) AddressType, MIN(s.AdminHold) AdminHold, MIN(s.AppliedToDocRef) AppliedToDocRef,
       MIN(s.ARAcct) ARAcct, MIN(s.ARBatNbr) ARBatNbr,
       MIN(s.ARDocType) ARDocType, MIN(s.ARSub) ARSub, MIN(s.ASID) ASID, MIN(s.ASID01) ASID01, MIN(s.AuthNbr) AuthNbr,
       MIN(s.AutoReleaseReturn) AutoReleaseReturn, Sum(sg.BalDue) BalDue, MIN(s.BIInvoice) BIInvoice,
       MIN(s.BillAddr1) BillAddr1, MIN(s.BillAddr2) BillAddr2, MIN(s.BillAddrSpecial) BillAddrSpecial,
       MIN(s.BillAttn) BillAttn, MIN(s.BillCity) BillCity,
       MIN(s.BillCountry) BillCountry, MIN(s.BillName) BillName, MIN(s.BillPhone) BillPhone,
       MIN(s.BillState) BillState, MIN(s.BillThruProject) BillThruProject,
       MIN(s.BillZip) BillZip, MIN(s.BlktOrdNbr) BlktOrdNbr, MIN(s.BMICost) BMICost,
       MIN(s.BMICuryID) BMICuryID, MIN(s.BMIEffDate) BMIEffDate,
       MIN(s.BMIMultDiv) BMIMultDiv, MIN(s.BMIRate) BMIRate, MIN(s.BMIRtTp) BMIRtTp,
       MIN(s.BookCntr) BookCntr, MIN(s.BookCntrMisc) BookCntrMisc,
       MIN(s.BoxCntr) BoxCntr, MIN(s.BuildActQty) BuildActQty, MIN(s.BuildCmpltDate) BuildCmpltDate,
       MIN(s.BuildInvtID) BuildInvtID, MIN(s.BuildLotSerCntr) BuildLotSerCntr,
       MIN(s.BuildQty) BuildQty, MIN(s.BuildTotalCost) BuildTotalCost, MIN(s.BuyerID) BuyerID,
       MIN(s.BuyerName) BuyerName, MIN(s.CancelBO) CancelBO,
       MIN(s.Cancelled) Cancelled, MIN(s.CancelOrder) CancelOrder, MIN(s.CertID) CertID,
       MIN(s.CertNoteID) CertNoteID, MIN(s.ChainDisc) ChainDisc,
       MIN(s.CmmnPct) CmmnPct, MIN(s.ConsolInv) ConsolInv, MIN(s.ContractNbr) ContractNbr,
       sg.CpnyID CpnyID, MIN(s.CreditApprDays) CreditApprDays,
       MIN(s.CreditApprLimit) CreditApprLimit, MIN(s.CreditChk) CreditChk, MIN(s.CreditHold) CreditHold,
       MIN(s.CreditHoldDate) CreditHoldDate, MIN(s.Crtd_DateTime) Crtd_DateTime,
       MIN(s.Crtd_Prog) Crtd_Prog, MIN(s.Crtd_User) Crtd_User, Sum(sg.CuryBalDue) CuryBalDue,
       MIN(s.CuryBuildTotCost) CuryBuildTotCost, MIN(s.CuryEffDate) CuryEffDate,
       MIN(s.CuryID) CuryID, MIN(s.CuryMultDiv) CuryMultDiv, Sum(sg.CuryPremFrtAmt) CuryPremFrtAmt,
       MIN(s.CuryRate) CuryRate, MIN(s.CuryRateType) CuryRateType,
       Sum(sg.CuryTotFrtCost) CuryTotFrtCost, Sum(sg.CuryTotFrtInvc) CuryTotFrtInvc, Sum(sg.CuryTotInvc) CuryTotInvc,
       Sum(sg.CuryTotLineDisc) CuryTotLineDisc, Sum(sg.CuryTotMerch) CuryTotMerch,
       Sum(sg.CuryTotMisc) CuryTotMisc, Sum(sg.CuryTotPmt) CuryTotPmt, Sum(sg.CuryTotTax) CuryTotTax,
       Sum(sg.CuryTotTxbl) CuryTotTxbl, Sum(sg.CuryWholeOrdDisc) CuryWholeOrdDisc,
       MIN(s.CustGLClassID) CustGLClassID, sg.CustID, sg.CustOrdNbr,
       MIN(s.DateCancelled) DateCancelled, MIN(s.Dept) Dept,
       MIN(s.DiscAcct) DiscAcct, MIN(s.DiscPct) DiscPct, MIN(s.DiscSub) DiscSub,
       MIN(s.Div) Div, MIN(s.DropShip) DropShip,
       MIN(s.EDI810) EDI810, MIN(s.EDI856) EDI856, MIN(s.EDIASNProcNbr) EDIASNProcNbr,
       MIN(s.EDIInvcProcNbr) EDIInvcProcNbr, MIN(s.ETADate) ETADate,
       MIN(s.FOBID) FOBID, MIN(s.FrtAcct) FrtAcct, MIN(s.FrtCollect) FrtCollect,
       MIN(s.FrtSub) FrtSub, MIN(s.FrtTermsID) FrtTermsID,
       MIN(s.GeoCode) GeoCode, MIN(s.INBatNbr) INBatNbr, MIN(s.InvcDate) InvcDate,
       sg.InvcNbr, MIN(s.InvcPrint) InvcPrint,
       MIN(s.LanguageID) LanguageID, MIN(s.LastAppendDate) LastAppendDate, MIN(s.LastAppendTime) LastAppendTime,
       MIN(s.LineCntr) LineCntr, MIN(s.LotSerialHold) LotSerialHold,
       MIN(s.LUpd_DateTime) LUpd_DateTime, MIN(s.LUpd_Prog) LUpd_Prog, MIN(s.LUpd_User) LUpd_User,
       MIN(s.MarkFor) MarkFor, MIN(s.MiscChrgCntr) MiscChrgCntr,
       MIN(s.NextFunctionClass) NextFunctionClass, MIN(s.NextFunctionID) NextFunctionID, MIN(s.NoteID) NoteID,
       MIN(s.OKToAppend) OKToAppend, MIN(s.OrdDate) OrdDate,
       MIN(s.OrdNbr) OrdNbr, MIN(s.OverridePerPost) OverridePerPost, MIN(s.PackDate) PackDate,
       MIN(s.PerClosed) PerClosed, MIN(s.PerPost) PerPost,
       MIN(s.PickDate) PickDate, MIN(s.PmtCntr) PmtCntr, MIN(s.PremFrt) PremFrt,
       Sum(sg.PremFrtAmt) PremFrtAmt, MIN(s.Priority) Priority,
       MIN(s.ProjectID) ProjectID, MIN(s.RelDate) RelDate, MIN(s.ReleaseValue) ReleaseValue,
       MIN(s.RequireStepAssy) RequireStepAssy, MIN(s.RequireStepInsp) RequireStepInsp,
       MIN(s.S4Future01) S4Future01, MIN(s.S4Future02) S4Future02, MIN(s.S4Future03) S4Future03,
       MIN(s.S4Future04) S4Future04, MIN(s.S4Future05) S4Future05,
       MIN(s.S4Future06) S4Future06, MIN(s.S4Future07) S4Future07, MIN(s.S4Future08) S4Future08,
       MIN(s.S4Future09) S4Future09, MIN(s.S4Future10) S4Future10,
       MIN(s.S4Future11) S4Future11, MIN(s.S4Future12) S4Future12, MIN(s.SellingSiteID) SellingSiteID,
       MIN(s.ShipAddr1) ShipAddr1, MIN(s.ShipAddr2) ShipAddr2,
       MIN(s.ShipAddrID) ShipAddrID, MIN(s.ShipAddrSpecial) ShipAddrSpecial, MIN(s.ShipAttn) ShipAttn,
       MIN(s.ShipCity) ShipCity, MIN(s.ShipCmplt) ShipCmplt,
       MIN(s.ShipCountry) ShipCountry, MIN(s.ShipCustID) ShipCustID, MIN(s.ShipDateAct) ShipDateAct,
       MIN(s.ShipDatePlan) ShipDatePlan, MIN(s.ShipGeoCode) ShipGeoCode,
       MIN(s.ShipName) ShipName, MIN(s.ShipperID) ShipperID, MIN(s.ShipPhone) ShipPhone,
       MIN(s.ShippingConfirmed) ShippingConfirmed, MIN(s.ShippingManifested) ShippingManifested,
       MIN(s.ShipRegisterID) ShipRegisterID, MIN(s.ShipSiteID) ShipSiteID, MIN(s.ShipState) ShipState,
       sg.ShiptoID, MIN(s.ShiptoType) ShiptoType,
       MIN(s.ShipVendAddrID) ShipVendAddrID, MIN(s.ShipVendID) ShipVendID, sg.ShipViaID,
       MIN(s.ShipZip) ShipZip, MIN(s.SiteID) SiteID,
       MIN(s.SlsperID) SlsperID, MIN(s.SOTypeID) SOTypeID, MIN(s.Status) Status,
       MIN(s.TaxID00) TaxID00, MIN(s.TaxID01) TaxID01,
       MIN(s.TaxID02) TaxID02, MIN(s.TaxID03) TaxID03, MIN(s.TermsID) TermsID,
       Sum(sg.TotBoxes) TotBoxes, MIN(s.TotCommCost) TotCommCost,
       MIN(s.TotCost) TotCost, Sum(sg.TotFrtCost) TotFrtCost, Sum(sg.TotFrtInvc) TotFrtInvc,
       Sum(sg.TotInvc) TotInvc, Sum(sg.TotLineDisc) TotLineDisc,
       Sum(sg.TotMerch) TotMerch, Sum(sg.TotMisc) TotMisc, Sum(sg.TotPallets) TotPallets,
       Sum(sg.TotPmt) TotPmt, Sum(sg.TotShipWght) TotShipWght,
       Sum(sg.TotTax) TotTax, Sum(sg.TotTxbl) TotTxbl, MIN(s.TrackingNbr) TrackingNbr,
       MIN(s.TransitTime) TransitTime, MIN(s.User1) User1,
       MIN(s.User10) User10, MIN(s.User2) User2, MIN(s.User3) User3,
       MIN(s.User4) User4, MIN(s.User5) User5,
       MIN(s.User6) User6, MIN(s.User7) User7, MIN(s.User8) User8,
       MIN(s.User9) User9, MIN(s.WeekendDelivery) WeekendDelivery,
       Sum(sg.WholeOrdDisc) WholeOrdDisc, MIN(s.WorkflowID) WorkflowID, MIN(s.WorkflowStatus) WorkflowStatus,
       MIN(s.WSID) WSID,MIN(s.WSID01) WSID01,
       MIN(s.Zone) Zone, MIN(s.tstamp) tstamp
  FROM soshipheader sg JOIN SOShipheader S
                         ON sg.CustOrdNbr = s.CustOrdNbr AND
                            sg.ShipToID = s.ShipToID AND
                            sg.Custid = s.CustID AND
                            sg.ShipToID = s.ShipToID AND
                            sg.InvcNbr = s.InvcNbr AND
                            sg.ShipRegisterID = s.ShipRegisterID AND
                            sg.ShipviaID = s.ShipViaID
                       JOIN edsoshipheader e
                         ON sg.cpnyid = e.cpnyid AND
                            sg.shipperid = e.shipperid
 WHERE sg.ShipRegisterId = @ShipRegisterId
   AND sg.EDI810 <> 0
   AND e.lastedidate = '1/1/1900'
   AND Sg.Cancelled = 0
   AND Sg.ConsolInv = 1
   AND ltrim(rtrim(sg.InvcNbr)) <> ''
   AND s.Shipperid = (SELECT min (shipperid)
                        FROM soshipheader sh
                       WHERE sg.CustOrdNbr = sh.CustOrdNbr
                         AND sg.ShipToID = sh.ShipToID
                         AND sg.CustID = sh.CustID
                         AND sg.ShipToID = sh.ShipToID
                         AND sg.InvcNbr = sh.InvcNbr
                         AND sg.ShipRegisterID = sh.ShipRegisterID
                         AND sg.ShipviaID = sh.ShipViaID)
   AND Exists (SELECT *
                 FROM EDOutbound
                WHERE EDOutbound.CustId = sg.CustId
                  AND EDOutbound.Trans In ('810','880'))

Group by sg.InvcNbr,sg.CustOrdNbr,sg.ShiptoID,sg.CustID,sg.CpnyID,sg.ShipViaID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSoShipHeader_EDIInvToSendConsolInv1] TO [MSDSL]
    AS [dbo];

