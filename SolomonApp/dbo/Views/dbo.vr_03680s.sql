 

--APPTABLE
--USETHISSYNTAX
/****** Last Modified by DCR on 9/10/98 ******/

CREATE VIEW vr_03680s AS

SELECT r.RI_ID, r.ReportDate, v.VendID, v.APAcct, v.APSub, v.VName, v.vStatus, Balance = SUM(v.DocBal),
	v.CpnyID, cRI_ID = c.RI_ID, c.CpnyName,
	Cur = SUM(CASE 
		WHEN r.ReportDate <= v.DueDate THEN v.DocBal ELSE 0 END),
	Past00 = SUM(CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue00) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) >= 1 THEN v.DocBal
		ELSE 0 END),
	Past01 = SUM(CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue01) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue00) THEN v.DocBal
		ELSE 0 END),
	Past02 = SUM(CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) <= CONVERT(INT, s.PastDue02) AND 
			DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue01) THEN v.DocBal
		ELSE 0 END),
	Over02 = SUM(CASE
		WHEN DATEDIFF(Day, v.DueDate, r.ReportDate) > CONVERT(INT, s.PastDue02) THEN v.DocBal
		ELSE 0 END),
       Max(v.VendorUser1) as VendorUser1, Max(v.VendorUser2) as VendorUser2, Max(v.VendorUser3) as VendorUser3, Max(v.VendorUser4) as VendorUser4,
       Max(v.VendorUser5) as VendorUser5, Max(v.VendorUser6) as VendorUser6, Max(v.VendorUser7) as VendorUser7, Max(v.VendorUser8) as VendorUser8
FROM vr_03680VendorDetail v, RptRuntime r, APSetup s (NOLOCK), RptCompany c
WHERE v.DocBal <> 0 AND r.ReportNbr = '03680' AND v.CpnyID = c.CpnyID
GROUP BY r.RI_ID, r.ReportDate, v.VendID, v.APAcct, v.APSub, v.VName, v.vStatus, v.CpnyID, c.RI_ID, c.CpnyName


 
