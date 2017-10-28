 

--APPTABLE
--USETHISSYNTAX

/****** Last Modified by DMK on 11/25/98 ******/

CREATE VIEW vr_03680d AS

SELECT r.RI_ID, r.ReportDate, v.Parent, v.Ord, v.vCuryID, v.APAcct, v.APSub, v.VendID, 
	v.VName, v.vStatus, v.dStatus, v.RefNbr, v.CuryID, v.DueDate, PayDate=(CASE WHEN v.DocType="AD" THEN NULL ELSE v.PayDate END), v.DiscDate, v.DocDate, 
	v.InvcNbr, v.InvcDate, v.DocType, v.OrigDocAmt, v.DocBal,  v.CuryOrigDocAmt, v.CuryDocBal, v.CpnyID, v.MasterDocNbr, v.S4Future11,
	cRI_ID = c.RI_ID, c.CpnyName,
	Cur = CASE 
		WHEN r.ReportDate <= v.DueDate THEN v.DocBal ELSE 0 END,
	Past00 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue00) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) >= 1 THEN v.DocBal
		ELSE 0 END,
	Past01 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue01) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue00) THEN v.DocBal
		ELSE 0 END,
	Past02 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue02) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue01) THEN v.DocBal
		ELSE 0 END,
	Over02 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue02) THEN v.DocBal
		ELSE 0 END, 
	cCur = CASE 
		WHEN r.ReportDate <= v.DueDate THEN v.CuryDocBal ELSE 0 END,
	cPast00 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue00) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) >= 1 THEN v.CuryDocBal
		ELSE 0 END,
	cPast01 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue01) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue00) THEN v.CuryDocBal
		ELSE 0 END,
	cPast02 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue02) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue01) THEN v.CuryDocBal
		ELSE 0 END,
	cOver02 = CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue02) THEN v.CuryDocBal
		ELSE 0 END,
       v.VendorUser1, v.VendorUser2, v.VendorUser3, v.VendorUser4,
       v.VendorUser5, v.VendorUser6, v.VendorUser7, v.VendorUser8,
       v.APDocUser1, v.APDocUser2, v.APDocUser3, v.APDocUser4, 
       v.APDocUser5, v.APDocUser6, v.APDocUser7, v.APDocUser8			
FROM vr_03680VendorDetail v, RptRuntime r, APSetup s (NOLOCK), RptCompany c
WHERE v.DocBal <> 0 AND r.ReportNbr = '03680' AND v.CpnyID = c.CpnyID



 
