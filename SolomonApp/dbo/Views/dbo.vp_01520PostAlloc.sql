 



CREATE VIEW vp_01520PostAlloc AS 

SELECT 	FiscYr = SUBSTRING(b.PerPost,1,4),  
	t.Sub, 
	CuryID = t.BaseCuryID,  
	t.LedgerID, 
	c.DecPl, 
	t.CpnyID,
	t.acct,
	Net00 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "01" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net01 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "02" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net02 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "03" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net03 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "04" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net04 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "05" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net05 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "06" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0	
	END),
	Net06 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "07" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net07 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "08" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net08 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "09" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net09 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "10" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)		ELSE 0	
	END),
	Net10 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "11" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net11 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "12" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	Net12 = SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "13" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END),
	NetYear = SUM(ROUND(t.CRAmt - t.DRAmt, c.DecPl)),
      UserAddress
FROM GLTran t, Batch b, /*Account a*/ Currncy c, WrkPost p
WHERE p.Batnbr = b.Batnbr AND p.Module = b.Module AND t.BatNbr = b.BatNbr AND t.Module = b.Module --AND t.Acct = a.Acct
AND t.BaseCuryID = c.CuryID --AND RIGHT(RTRIM(a.AcctType),1) IN ("E","I","A","L")
AND t.OrigAcct = ' ' AND t.OrigSub = ' ' AND b.Battype = 'A' AND t.TranType = 'LS'
GROUP BY SUBSTRING(b.PerPost,1,4), t.Sub, t.BaseCuryID, c.DecPl, t.LedgerID, t.CpnyID, UserAddress, t.acct


 
