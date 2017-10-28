 

--APPTABLE
--USETHISSYNTAX

/****** Last Modified by Phat Ho on 9/18/98 ******/
/****** Last Modified by DCR on 9/19/98 ******/

CREATE VIEW vr_03680su AS

SELECT r.RI_ID, r.ReportDate, v.VendID, v.APAcct, v.APSub, v.VName, v.vStatus, Balance = SUM(v.DocBal),
	v.CpnyID, cRI_ID = c.RI_ID, c.CpnyName,
	Cur = SUM(CASE 
		WHEN v.DueDate <= r.ReportDate THEN v.DocBal  ELSE 0  END),
	Untl00 = SUM(CASE
		WHEN DATEDIFF(Day, r.ReportDate,v.DueDate) <= CONVERT(INT, s.UntlDue00) AND 
			DATEDIFF(Day,  r.ReportDate, v.DueDate) >= 1 THEN v.DocBal
		ELSE 0 END),
	Untl01 = SUM(CASE
		WHEN DATEDIFF(Day, r.ReportDate,v.DueDate) <= CONVERT(INT, s.UntlDue01) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue00) THEN v.DocBal
		ELSE 0 END),
	Untl02 = SUM(CASE
		WHEN DATEDIFF(Day, r.ReportDate,v.DueDate) <= CONVERT(INT, s.UntlDue02) AND 
			DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue01) THEN v.DocBal
		ELSE 0 END),
	Over02 = SUM(CASE
		WHEN DATEDIFF(Day, r.ReportDate, v.DueDate) > CONVERT(INT, s.UntlDue02) THEN v.DocBal
		ELSE 0 END),
       Max(v.VendorUser1) as VendorUser1, Max(v.VendorUser2) as VendorUser2, Max(v.VendorUser3) as VendorUser3, Max(v.VendorUser4) as VendorUser4,
       Max(v.VendorUser5) as VendorUser5, Max(v.VendorUser6) as VendorUser6, Max(v.VendorUser7) as VendorUser7, Max(v.VendorUser8) as VendorUser8
FROM vr_03680VendorDetail v, RptRuntime r, APSetup s (NOLOCK), RptCompany c
WHERE v.DocBal <> 0 AND r.ReportNbr = '03680' AND v.CpnyID = c.CpnyID
GROUP BY r.RI_ID, r.ReportDate, v.VendID, v.APAcct, v.APSub, v.VName, v.vStatus, v.CpnyID, c.RI_ID, c.CpnyName


 
