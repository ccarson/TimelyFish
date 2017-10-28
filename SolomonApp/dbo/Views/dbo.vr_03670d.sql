 
--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_03670d AS

SELECT	e.doctype, e.EDD, e.OrdFromID, e.DeliveryMethod, e.RequestorsEmail, e.EmailFileType, e.FaxReceiverName, e.EDDFaxPrefix, e.EDDFax, e.UsePOEmail, VendIDEDD = e.VendID,
    v.Addr1, v.Addr2, v.APAcct, v.APSub, v.Attn, v.City, v.Country, v.Curr1099Yr, v.CuryId, v.CuryRateType,
	v.DfltBox, v.DfltOrdFromId, v.EMailAddr, v.ExpAcct, v.ExpSub, v.Fax, v.Name,
	v.Next1099Yr, v.PayDateDflt, h.PerNbr,
	v.Phone, v.PmtMethod, v.Salut, v.State, v.Status, v.TaxDflt, v.TaxId00, v.TaxId01, v.TaxId02, v.TaxId03, v.TaxLocId,
	v.TaxPost, v.TaxRegNbr, v.Terms, v.TIN, v.Vend1099, v.VendId, v.Zip, h.FiscYr,
	PtdPaymt=CASE SUBSTRING(h.PerNbr,5,2) WHEN '01' THEN h.PtdPaymt00 WHEN '02' THEN h.PtdPaymt01
		WHEN '03' THEN h.PtdPaymt02 WHEN '04' THEN h.PtdPaymt03 WHEN '05' THEN h.PtdPaymt04
		WHEN '06' THEN h.PtdPaymt05 WHEN '07' THEN h.PtdPaymt06 WHEN '08' THEN h.PtdPaymt07
		WHEN '09' THEN h.PtdPaymt08 WHEN '10' THEN h.PtdPaymt09 WHEN '11' THEN h.PtdPaymt10
		WHEN '12' THEN h.PtdPaymt11 WHEN '13' THEN h.PtdPaymt12 ELSE 0 END,
	PtdPurch=CASE SUBSTRING(h.PerNbr,5,2) WHEN '01' THEN h.PtdPurch00 WHEN '02' THEN h.PtdPurch01
		WHEN '03' THEN h.PtdPurch02 WHEN '04' THEN h.PtdPurch03 WHEN '05' THEN h.PtdPurch04
		WHEN '06' THEN h.PtdPurch05 WHEN '07' THEN h.PtdPurch06 WHEN '08' THEN h.PtdPurch07
		WHEN '09' THEN h.PtdPurch08 WHEN '10' THEN h.PtdPurch09 WHEN '11' THEN h.PtdPurch10
		WHEN '12' THEN h.PtdPurch11 WHEN '13' THEN h.PtdPurch12 ELSE 0 END,
	YtdPurch=COALESCE(h.YtdPurch, 0), YtdPaymt=COALESCE(h.YtdPaymt, 0), b.LastChkDate, b.LastVODate,
	YtdCrAdjs=COALESCE(h.YtdCrAdjs, 0), YtdDrAdjs=COALESCE(h.YtdDrAdjs, 0), YtdDiscTkn=COALESCE(h.YtdDiscTkn, 0),
	PODescr=p.Descr, TermsDescr=t.Descr,
	b.CYBox00, b.CYBox01, b.CYBox02, b.CYBox03, b.CYBox04, b.CYBox05, b.CYBox06, b.CYBox07, 
	BegBal=COALESCE(h.BegBal, 0), CurrBal=COALESCE(b.CurrBal, 0), FutureBal=COALESCE(b.FutureBal, 0), c.CpnyID, 
	cRI_ID=c.RI_ID, c.CpnyName, BalDecPl = COALESCE(bc.DecPl,0), HistDecPl = COALESCE(hc.DecPl,0),
        v.User1,v.User2,v.User3,v.User4,v.User5,v.User6,v.User7,v.User8, YtdBkupWthld = coalesce(h.YtdBkupWthld, 0), ReqBkupWthld = v.ReqBkupWthld
FROM	RptRuntime r INNER JOIN RptCompany c ON r.RI_ID=c.RI_ID AND r.ReportNbr ='03670' CROSS JOIN Vendor v
	LEFT JOIN Terms t ON v.Terms = t.TermsId LEFT JOIN POAddress p ON v.VendId = p.VendId
	LEFT JOIN AP_Balances b ON c.CpnyID=b.CpnyID AND v.VendID=b.VendID
	LEFT JOIN APHist h ON v.VendID=h.VendID AND c.CpnyID=h.CpnyID AND v.PerNbr=h.PerNbr
	LEFT JOIN Currncy bc (NOLOCK) ON b.CuryID=bc.CuryID
	LEFT JOIN Currncy hc (NOLOCK) ON h.CuryID=hc.CuryID
    LEFT JOIN Vendedd e (NOLOCK) ON v.vendid=e.vendid
WHERE	r.ShortAnswer00='FALSE' OR b.CpnyID IS NOT NULL


 
