 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vr_03680du AS

SELECT r.RI_ID, r.ReportDate, v.Parent, v.Ord, v.vCuryID, v.APAcct, v.APSub, v.VendID, 
	v.VName, v.vStatus, v.dStatus, v.RefNbr, v.CuryID, v.DueDate, PayDate=(CASE WHEN v.DocType= 'AD' THEN NULL ELSE v.PayDate END), v.DiscDate, v.DocDate, 
	v.InvcNbr, v.InvcDate, v.DocType, v.OrigDocAmt, v.DocBal,  v.CuryOrigDocAmt, v.CuryDocBal, v.CpnyID, v.MasterDocNbr, v.S4Future11,
	cRI_ID = c.RI_ID, c.CpnyName,
	Cur = CASE 
		WHEN v.DueDate <= r.ReportDate THEN v.DocBal ELSE 0 END,
	Untl00 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) <= CONVERT(INT, s.UntlDue00) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) >= 1 THEN v.DocBal
		ELSE 0 END,
	Untl01 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) <= CONVERT(INT, s.UntlDue01) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue00) THEN v.DocBal
		ELSE 0 END,
	Untl02 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) <= CONVERT(INT, s.UntlDue02) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue01) THEN v.DocBal
		ELSE 0 END,
	Over02 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue02) THEN v.DocBal
		ELSE 0 END, 
	cCur = CASE 
		WHEN v.DueDate <= r.ReportDate THEN v.CuryDocBal ELSE 0 END,
	cUntl00 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) <= CONVERT(INT, s.UntlDue00) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) >= 1 THEN v.CuryDocBal
		ELSE 0 END,
	cUntl01 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) <= CONVERT(INT, s.UntlDue01) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue00) THEN v.CuryDocBal
		ELSE 0 END,
	cUntl02 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) <= CONVERT(INT, s.UntlDue02) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue01) THEN v.CuryDocBal
		ELSE 0 END,
	cOver02 = CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue02) THEN v.CuryDocBal
		ELSE 0 END,
       v.VendorUser1, v.VendorUser2, v.VendorUser3, v.VendorUser4,
       v.VendorUser5, v.VendorUser6, v.VendorUser7, v.VendorUser8,
       v.APDocUser1, v.APDocUser2, v.APDocUser3, v.APDocUser4, 
       v.APDocUser5, v.APDocUser6, v.APDocUser7, v.APDocUser8
FROM vr_03680VendorDetail v, RptRuntime r, APSetup s (NOLOCK), RptCompany c
WHERE v.DocBal <> 0 AND r.ReportNbr = '03680' AND v.CpnyID = c.CpnyID

 
