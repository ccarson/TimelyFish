 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_01520PostNetInc AS 

SELECT 	FiscYr = SUBSTRING(b.PerPost,1,4),  
	t.Sub, 
	CuryID = t.BaseCuryID,  
	t.LedgerID, 
	c.DecPl, 
	t.CpnyID,
	Net00 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "01" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net01 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "02" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net02 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "03" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net03 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "04" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net04 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "05" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net05 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "06" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0	
	END), c.DecPl),
	Net06 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "07" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net07 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "08" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net08 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "09" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net09 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "10" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0	
	END), c.DecPl),
	Net10 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "11" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net11 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "12" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	Net12 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN "13" THEN ROUND(t.CRAmt - t.DRAmt, c.DecPl)
		ELSE 0
	END), c.DecPl),
	NetYear = ROUND(SUM(ROUND(t.CRAmt - t.DRAmt, c.DecPl)), c.DecPl),
      UserAddress
FROM GLTran t, Batch b, Account a, Currncy c, WrkPost p
WHERE p.Batnbr = b.Batnbr AND p.Module = b.Module AND t.BatNbr = b.BatNbr AND t.Module = b.Module AND t.Acct = a.Acct 
AND t.BaseCuryID = c.CuryID AND RIGHT(RTRIM(a.AcctType),1) IN ("E","I") 
GROUP BY SUBSTRING(b.PerPost,1,4), t.Sub, t.BaseCuryID, c.DecPl, t.LedgerID, t.CpnyID, UserAddress

 
