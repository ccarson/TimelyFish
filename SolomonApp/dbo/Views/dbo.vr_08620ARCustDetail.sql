 


CREATE VIEW vr_08620ARCustDetail AS
SELECT Distinct v.Parent,
	v.Ord, d.CustID, v.dStatus, 
	RefNbr = CASE WHEN v.Ord=2 AND v.DocType='SC' THEN v.AdjdRefNbr ELSE v.RefNbr END,
	v.DueDate,
	v.DiscDate,
	v.DocDate,
	DocType = CASE WHEN v.Ord=2 AND v.DocType='SC' THEN v.PDocType ELSE v.DocType END,
	v.DocDesc,
	v.PerEnt,
	v.PerPost,
	v.PerClosed,
	OrigDocAmt = CASE WHEN v.Ord=2 AND v.DocType='SC' THEN -v.OrigDocAmt ELSE v.OrigDocAmt END,
	v.DocBal,
	CuryOrigDocAmt = CASE WHEN v.Ord=2 AND v.DocType='SC' THEN -v.CuryOrigDocAmt ELSE v.CuryOrigDocAmt END,
	v.CuryDocBal,
	v.CuryID,
	PDocType = CASE WHEN v.Ord=2 AND v.DocType='SC' THEN v.DocType ELSE v.PDocType END,
	AdjdRefNbr = CASE WHEN v.Ord=2 AND v.DocType='SC' THEN v.RefNbr ELSE v.AdjdRefNbr END,

	CName = SUBSTRING(CASE 
		WHEN CHARINDEX("~", c.Name) > 0 
		THEN LTRIM(RTRIM(RIGHT(LTRIM(RTRIM(c.Name)), DATALENGTH(LTRIM(RTRIM(c.Name))) - CHARINDEX("~", LTRIM(c.Name))))) + " " + SUBSTRING(LTRIM(c.Name), 1, (CHARINDEX("~", LTRIM(c.Name)) - 1))
		ELSE c.Name 
	END, 1, 30), d.CpnyID, c.StmtCycleId, 
	Descr = (Case When d.terms = ' '  then ' ' else t.descr end),
	 c.BillPhone, c.BillAttn, b.AvgDayToPay,
        cStatus = c.Status, 
	ARAcct = (Case when d.doctype in ('PA', 'SC') then c.aracct when d.doctype = 'PP' then C.PrePayAcct  else d.BankAcct end), 
	ARSub = (Case when d.doctype in ('PA', 'SC') then c.arsub when d.doctype = 'PP' then C.PrePaySub else d.BankSub end), 
	cCuryID = c.CuryID, b.CurrBal, b.LastAgeDate, 
	AgeDays00 = CONVERT(INT,s.AgeDays00), AgeDays01 = CONVERT(INT,s.AgeDays01), 
	AgeDays02 = CONVERT(INT,s.AgeDays02), 
	DocOpen = CASE WHEN d.DocBal <> 0 THEN 1 ELSE 0 END,
	Applied = CASE 
	            WHEN v.DocType = "PA" AND v.CuryDocBal <> 0 THEN 0
	            ELSE 1
		  END


FROM Customer c, vr_08620ARDetail v, ARStmt s, ARDoc d, AR_Balances b, terms t

WHERE c.CustId = v.CustId AND b.CustID = v.CustID AND b.CpnyID = d.CpnyID 
AND c.StmtCycleId = s.StmtCycleId 
AND (v.Ord = 1 OR v.Ord = 3 OR (v.Ord = 2 AND (v.OrigDocAmt < 0 AND v.DocType<>'SC' OR v.DocType='SC' AND v.OrigDocAmt>0))) 
AND v.PDocType = d.DocType 
AND v.AdjdRefNbr = d.RefNbr 
AND (d.Terms = t.TermsID Or (d.terms = ' ' and (d.doctype IN ("PA", "PP", "NS", "FI", "SC") or (v.doctype = "NC"))))
AND v.CustID = d.CustID 



 
