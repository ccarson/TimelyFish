 

CREATE VIEW vr_08610sp AS

SELECT r.RI_ID, r.ReportDate, d.CustID, 
        CName = c.Name,
	cStatus=c.Status, b.LastAgeDate, c.BillPhone, c.BillAttn, b.AvgDayToPay, c.StmtCycleId,
	ARSub=CASE d.DocType WHEN 'PA' THEN c.ARSub WHEN 'PP' THEN c.PrePaySub ELSE d.BankSub END,
	d.CpnyID, cRI_ID = r.RI_ID, y.CpnyName, 
	Cur = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE 
		WHEN d.DocType NOT IN ('CM', 'PA', 'PP') AND r.ReportDate <= d.DueDate OR
		d.DocType IN ('CM', 'PA', 'PP') AND (r.ReportDate<=d.DocDate OR ARSetup.S4Future09=0) THEN d.DocBal ELSE 0 END),
	Past00 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays00 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) >= 1 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END),
	Past01 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays01 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays00 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END),
	Past02 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays02 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays01 AND 
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END),
	Over02 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays02 AND
               (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END), 
	cCur = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE 
		WHEN d.DocType NOT IN ('CM', 'PA', 'PP') AND r.ReportDate <= d.DueDate OR
		d.DocType IN ('CM', 'PA', 'PP') AND (r.ReportDate<=d.DocDate OR ARSetup.S4Future09=0) THEN d.CuryDocBal ELSE 0 END),
	cPast00 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays00 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) >= 1 AND 
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END),
	cPast01 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays01 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays00 AND
                       (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END),
	cPast02 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays02 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays01 AND
                       (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END),
	cOver02 = SUM(CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays02 AND
                       (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END),
	sAgeDays00 = Min(s.AgeDays00),
	sAgeDays01 = Min(s.AgeDays01),
	sAgeDays02 = Min(s.AgeDays02),
       	Max(c.User1) as CustUser1, Max(c.User2) as CustUser2, Max(c.User3) as CustUser3, Max(c.User4) as CustUser4,
       	Max(c.User5) as CustUser5, Max(c.User6) as CustUser6, Max(c.User7) as CustUser7, Max(c.User8) as CustUser8
FROM	RptRuntime r INNER JOIN RptCompany y 
                             ON y.RI_ID=r.RI_ID 
                     INNER JOIN ARDoc d 
                             ON d.CpnyID=y.CpnyID 
                     INNER JOIN	AR_Balances b 
                             ON b.CpnyID=y.CpnyID AND b.CustID=d.CustID 
                     INNER JOIN Customer c 
                             ON c.CustID=d.CustID 
                     INNER JOIN	(SELECT StmtCycleID, AgeDays00 = CONVERT(INT,AgeDays00), 
                                        AgeDays01 = CONVERT(INT,AgeDays01), AgeDays02 = CONVERT(INT,AgeDays02) 
                                   FROM ARStmt) s 
                             ON s.StmtCycleID=c.StmtCycleID 
                      LEFT JOIN Terms t 
                             ON	d.Terms <> '' AND t.TermsID=d.Terms 
                     CROSS JOIN ARSetup (NOLOCK)
WHERE	r.ReportNbr='08610' AND d.Rlsed=1 AND d.CuryDocBal<>0
GROUP BY r.RI_ID, r.ReportDate, d.CustID, c.Name, c.Status, b.LastAgeDate, c.StmtCycleId, 
	CASE d.DocType WHEN 'PA' THEN c.ARSub WHEN 'PP' THEN c.PrePaySub ELSE d.BankSub END,
	d.CpnyID, c.BillPhone, c.BillAttn, b.AvgDayToPay, y.CpnyName


 
