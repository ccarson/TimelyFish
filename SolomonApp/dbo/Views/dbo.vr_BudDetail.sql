 




CREATE VIEW vr_BudDetail AS 

SELECT b.ActualLedgerID,
	 b.BdgtSegment,
	 b.BeginDate,
	 b.BudgetLedgerID,
	 b.BudgetYear,
	 b.CpnyID,
	 b.EndDate,
	 b.ShortDescr,
         A2.AnnBdgt,
	 A2.YTDEstimated,
	 a2.Acct,
	 d.Descr,
         r.CpnyName,
	 r.RI_ID,
	 ActPTD00 = A1.PTDBal00,  
	 ActPTD01 = A1.PTDBal01,
	 ActPTD02 = A1.PTDBal02,
	 ActPTD03 = A1.PTDBal03,
	 ActPTD04 = A1.PTDBal04,
	 ActPTD05 = A1.PTDBal05,
	 ActPTD06 = A1.PTDBal06,
	 ActPTD07 = A1.PTDBal07,
	 ActPTD08 = A1.PTDBal08,
	 ActPTD09 = A1.PTDBal09,
	 ActPTD10 = A1.PTDBal10,
	 ActPTD11 = A1.PTDBal11,
	 ActPTD12 = A1.PTDBal12,
 	 BdgtPTD00 = A2.PTDBal00,  
	 BdgtPTD01 = A2.PTDBal01,
	 BdgtPTD02 = A2.PTDBal02,
	 BdgtPTD03 = A2.PTDBal03,
	 BdgtPTD04 = A2.PTDBal04,
	 BdgtPTD05 = A2.PTDBal05,
	 BdgtPTD06 = A2.PTDBal06,
	 BdgtPTD07 = A2.PTDBal07,
	 BdgtPTD08 = A2.PTDBal08,
	 BdgtPTD09 = A2.PTDBal09,
	 BdgtPTD10 = A2.PTDBal10,
	 BdgtPTD11 = A2.PTDBal11,
	 BdgtPTD12 = A2.PTDBal12,
       	 b.User1 as BudgetUser1, b.User2 as BudgetUser2, b.User3 as BudgetUser3, b.User4 as BudgetUser4,
       	 b.User5 as BudgetUser5, b.User6 as BudgetUser6, b.User7 as BudgetUser7, b.User8 as BudgetUser8

FROM GLSetup g (NOLOCK), Budget b,AcctHist A1, AcctHist A2, Account d, rptcompany r
WHERE A1.LedgerID = g.LedgerID
AND b.BudgetYear = A1.Fiscyr
AND b.CpnyID = A1.CpnyID
AND b.BdgtSegment = A1.Sub
AND A1.Acct = d.Acct
and a2.LedgerID = b.BudgetLedgerID
AND b.BudgetYear = A2.Fiscyr
AND b.CpnyID = A2.CpnyID
AND b.BdgtSegment = A2.Sub
AND A2.Acct = d.Acct
AND b.CpnyID = r.cpnyID



 
