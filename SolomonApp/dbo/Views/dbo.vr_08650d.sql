 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vr_08650d AS

SELECT
	d.DocType, d.ShipToID, CustIDEDD = d.custId, d.DeliveryMethod, d.RequestorsEmail, d.EmailFileType, d.FaxReceiverName, 
	d.EDDFaxPrefix, d.EDDFax, v.Addr1, v.Addr2, v.ApplFinChrg, v.ArAcct, v.ArSub, v.Attn, v.AutoApply, 
    v.BillAddr1, v.BillAddr2, v.BillAttn, v.BillCity, v.BillCountry, v.BillFax, v.BillName, 
    v.BillPhone, v.BillSalut, v.BillState, v.BillZip, v.City, v.ClassId, v.Country, v.CrLmt, 
    v.CuryId, v.CuryPrcLvlRtTp, v.CuryRateType, CustCustID=v.CustId, v.DunMsg, v.Fax, v.InvtSubst, v.Name, 
    v.Phone, v.PrcLvlId, v.PrtStmt, v.Salut, v.ShipCmplt, v.SlsAcct, v.SlsperId, v.SlsSub, 
    v.State, v.Status, v.StmtCycleId, v.StmtType, v.TaxDflt, v.TaxID00, v.TaxID01, v.TaxID02, 
    v.TaxID03, v.TaxLocId, v.TaxRegNbr, v.Terms, v.TradeDisc, v.Zip,
    b.AvgDayToPay, b.CpnyID, b.CurrBal, 
    BalCustID = b.CustID, b.FutureBal, 
    b.LastActDate, b.LastAgeDate, b.LastFinChrgDate, b.LastInvcDate, b.LastStmtBal00, 
    b.LastStmtDate, BalPerNbr=b.PerNbr, b.TotOpenOrd, h.FiscYr, HistPerNbr=h.PerNbr, 
    h.PTDCOGS00, h.PTDCOGS01, h.PTDCOGS02, h.PTDCOGS03, h.PTDCOGS04, 
    h.PTDCOGS05, h.PTDCOGS06, h.PTDCOGS07, h.PTDCOGS08, h.PTDCOGS09, h.PTDCOGS10, h.PTDCOGS11,
    h.PTDCOGS12, h.PTDCrMemo00, h.PTDCrMemo01, h.PTDCrMemo02, h.PTDCrMemo03, h.PTDCrMemo04, 
    h.PTDCrMemo05, h.PTDCrMemo06, h.PTDCrMemo07, h.PTDCrMemo08, h.PTDCrMemo09, h.PTDCrMemo10, 
    h.PTDCrMemo11, h.PTDCrMemo12, h.PTDDisc00, h.PTDDisc01, h.PTDDisc02, h.PTDDisc03, 
    h.PTDDisc04, h.PTDDisc05, h.PTDDisc06, h.PTDDisc07, h.PTDDisc08, h.PTDDisc09, h.PTDDisc10,
    h.PTDDisc11, h.PTDDisc12, h.PTDDrMemo00, h.PTDDrMemo01, h.PTDDrMemo02, h.PTDDrMemo03, 
    h.PTDDrMemo04, h.PTDDrMemo05, h.PTDDrMemo06, h.PTDDrMemo07, h.PTDDrMemo08, h.PTDDrMemo09, 
    h.PTDDrMemo10, h.PTDDrMemo11, h.PTDDrMemo12, h.PTDFinChrg00, h.PTDFinChrg01, 
    h.PTDFinChrg02, h.PTDFinChrg03, h.PTDFinChrg04, h.PTDFinChrg05, h.PTDFinChrg06, 
    h.PTDFinChrg07, h.PTDFinChrg08, h.PTDFinChrg09, h.PTDFinChrg10, h.PTDFinChrg11, 
    h.PTDFinChrg12, h.PTDRcpt00, h.PTDRcpt01, h.PTDRcpt02, h.PTDRcpt03, h.PTDRcpt04, 
    h.PTDRcpt05, h.PTDRcpt06, h.PTDRcpt07, h.PTDRcpt08, h.PTDRcpt09, h.PTDRcpt10, 
    h.PTDRcpt11, h.PTDRcpt12, h.PTDSales00, h.PTDSales01, h.PTDSales02, h.PTDSales03, 
    h.PTDSales04, h.PTDSales05, h.PTDSales06, h.PTDSales07, h.PTDSales08, h.PTDSales09, 
    h.PTDSales10, h.PTDSales11, h.PTDSales12, h.YtdCOGS, h.YtdCrMemo, h.YtdDisc, h.YtdDrMemo, 
    h.YtdFinChrg, c.CpnyName, h.YtdRcpt, h.YtdSales,  
    cRI_ID = c.RI_ID,
    e.CreditMgrID, e.CreditRule, e.GracePer,
    v.User1 as CustUser1, v.User2 as CustUser2, v.User3 as CustUser3, v.User4 as CustUser4,
    v.User5 as CustUser5, v.User6 as CustUser6, v.User7 as CustUser7, v.User8 as CustUser8,
    a.User1 as AddrUser1, a.User2 as AddrUser2, a.User3 as AddrUser3, a.User4 as AddrUser4,
    a.User5 as AddrUser5, a.User6 as AddrUser6, a.User7 as AddrUser7, a.User8 as AddrUser8
FROM Customer v LEFT OUTER JOIN AR_Balances b 
                  ON v.CustId = b.CustID
                LEFT OUTER JOIN SOAddress a 
                  ON v.CustId = a.CustId
                JOIN RptCompany c 
                  ON ISNULL(b.CpnyID,c.Cpnyid) = c.CpnyID
                LEFT OUTER JOIN ARHist h 
                  ON c.CpnyID = h.CpnyID AND b.CustID = h.CustId 
                 AND SUBSTRING(b.PerNbr,1,4) = h.Fiscyr
                LEFT OUTER JOIN CustomerEDI e 
                  ON v.Custid = e.Custid
                LEFT JOIN CustEdd d (NOLOCK) 
                  ON v.Custid=d.Custid
                   
