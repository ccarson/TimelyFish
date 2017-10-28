 

CREATE VIEW vr_08610dp AS

SELECT r.RI_ID, r.ReportDate, Parent=d.RefNbr, Ord=1, cCuryID=c.CuryID,
	ARAcct =CASE d.DocType WHEN 'PA' THEN c.ARAcct WHEN 'PP' THEN c.PrePayAcct ELSE d.BankAcct END,
	ARSub = CASE d.DocType WHEN 'PA' THEN c.ARSub  WHEN 'PP' THEN c.PrePaySub ELSE d.BankSub END,
	d.CustID, 
	CName = c.Name,
	cStatus = c.Status, d.RefNbr, d.CuryID, d.DueDate, d.DiscDate, d.DocDate, d.DocType,
	OrigDocAmt =     CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * d.OrigDocAmt,
	DocBal =         CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * d.DocBal,
	CuryOrigDocAmt = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * d.CuryOrigDocAmt,
	CuryDocBal =     CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * d.CuryDocBal, 
	c.StmtCycleID, Descr = ISNULL(t.Descr, ''), c.BillPhone, c.BillAttn, b.AvgDayToPay,
	d.CpnyID, cRI_ID = r.RI_ID, y.CpnyName, d.SlsperId,
	Cur = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') 
                    THEN 1 
                   ELSE -1 
              END * CASE WHEN d.DocType NOT IN ('CM', 'PA', 'PP') AND r.ReportDate <= d.DueDate 
                                  OR d.DocType IN ('CM', 'PA', 'PP') AND (r.ReportDate<=d.DocDate OR ARSetup.S4Future09=0) 
                            THEN d.DocBal 
                         ELSE 0 
                    END,
	Past00 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') 
                       THEN 1 
                      ELSE -1 
                 END * CASE WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') 
                                                      THEN d.DocDate 
                                                    ELSE d.DueDate 
                                               END, r.ReportDate) <= s.AgeDays00 AND 
			         DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') 
                                                      THEN d.DocDate  
                                                    ELSE d.DueDate 
                                               END, r.ReportDate) >= 1 AND
                                 (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) 
                              THEN d.DocBal
		            ELSE 0 END,
	Past01 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays01 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays00 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END,
	Past02 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays02 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays01 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END,
	Over02 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays02 AND 
                (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.DocBal
		ELSE 0 END, 
	cCur = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE 
		WHEN d.DocType NOT IN ('CM', 'PA', 'PP') AND r.ReportDate <= d.DueDate OR
		d.DocType IN ('CM', 'PA', 'PP') AND (r.ReportDate<=d.DocDate OR ARSetup.S4Future09=0 ) THEN d.CuryDocBal ELSE 0 END,
	cPast00 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays00 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) >= 1 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END,
	cPast01 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays01 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays00 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END,
	cPast02 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) <= s.AgeDays02 AND 
			DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays01 AND
                        (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END,
	cOver02 = CASE WHEN d.DocType IN ('IN','DM','FI','NC','AD') THEN 1 ELSE -1 END * CASE
		WHEN DATEDIFF(Day, CASE WHEN d.DocType IN ('CM', 'PA', 'PP') THEN d.DocDate ELSE d.DueDate END, r.ReportDate) > s.AgeDays02 AND 
               (d.DocType NOT IN ('CM', 'PA', 'PP') OR ARSetup.S4Future09=1) THEN d.CuryDocBal
		ELSE 0 END,
	AgeDays00 = s.AgeDays00,
	AgeDays01 = s.AgeDays01,
	AgeDays02 = s.AgeDays02,
       	c.User1 as CustUser1, c.User2 as CustUser2, c.User3 as CustUser3, c.User4 as CustUser4,
       	c.User5 as CustUser5, c.User6 as CustUser6, c.User7 as CustUser7, c.User8 as CustUser8,
       	d.User1 as ARDocUser1, d.User2 as ARDocUser2, d.User3 as ARDocUser3, d.User4 as ARDocUser4, 
       	d.User5 as ARDocUser5, d.User6 as ARDocUser6, d.User7 as ARDocUser7, d.User8 as ARDocUser8	
  FROM  RptRuntime r INNER JOIN RptCompany y 
                             ON y.RI_ID=r.RI_ID 
                     INNER JOIN ARDoc d 
                             ON d.CpnyID=y.CpnyID 
                     INNER JOIN	AR_Balances b
                             ON b.CpnyID=y.CpnyID AND b.CustID=d.CustID 
                     INNER JOIN Customer c 
                             ON c.CustID=d.CustID 
                     INNER JOIN (SELECT StmtCycleID, AgeDays00 = CONVERT(INT,AgeDays00), 
                                        AgeDays01 = CONVERT(INT,AgeDays01), AgeDays02 = CONVERT(INT,AgeDays02) 
                                   FROM ARStmt) s 
                             ON s.StmtCycleID=c.StmtCycleID 
                      LEFT JOIN Terms t 
                             ON	d.Terms <> '' AND t.TermsID=d.Terms 
                     CROSS JOIN ARSetup (NOLOCK)
 WHERE r.ReportNbr='08610' AND d.Rlsed=1 AND d.CuryDocBal<>0


 
