 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_01520PostNetIncMC AS

SELECT 	FiscYr = SUBSTRING(b.PerPost,1,4),  
	t.Sub, 
	t.BaseCuryID,  
	c1.DecPl,
	t.CuryID,
	CuryDecPl = c2.DecPl,
	t.LedgerID, 
	t.CpnyID,
	Net00 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '01' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net01 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '02' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net02 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '03' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0	END), c1.DecPl),
	Net03 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '04' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net04 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '05' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net05 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '06' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0	
	END), c1.DecPl),
	Net06 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '07' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net07 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '08' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net08 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '09' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net09 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '10' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0	
	END), c1.DecPl),
	Net10 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '11' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net11 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '12' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	Net12 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '13' THEN ROUND(t.CRAmt - t.DRAmt, c1.DecPl)
		ELSE 0
	END), c1.DecPl),
	NetYear = ROUND(SUM(ROUND(t.CRAmt - t.DRAmt, c1.DecPl)), c1.DecPl),
	CuryNet00 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '01' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet01 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '02' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet02 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '03' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet03 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '04' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet04 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '05' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet05 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '06' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0	
	END), c2.DecPl),
	CuryNet06 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '07' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet07 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '08' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet08 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '09' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet09 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '10' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0	
	END), c2.DecPl),
	CuryNet10 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '11' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet11 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '12' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNet12 = ROUND(SUM(CASE RIGHT(RTRIM(b.PerPost),2)
		WHEN '13' THEN ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)
		ELSE 0
	END), c2.DecPl),
	CuryNetYear = ROUND(SUM(ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl)), c2.DecPl),
        UserAddress



FROM GLTran t, Batch b, Account a, Currncy c1, Currncy c2, Wrkpost p
WHERE p.Batnbr = B.Batnbr AND t.BatNbr = b.BatNbr AND t.Module = b.Module AND t.Acct = a.Acct AND b.module = p.module 
AND t.BaseCuryID = c1.CuryID AND t.CuryID = c2.CuryID AND RIGHT(RTRIM(a.AcctType),1) IN ('E','I')
GROUP BY SUBSTRING(b.PerPost,1,4), t.Sub, t.BaseCuryID, c1.DecPl, t.CuryID, c2.DecPl, 
t.LedgerID, t.CpnyID,UserAddress

 
