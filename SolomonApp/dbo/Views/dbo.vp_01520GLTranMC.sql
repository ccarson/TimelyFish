 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_01520GLTranMC AS

SELECT 	Period = RIGHT(RTRIM(b.PerPost),2), 
	FiscYr = SUBSTRING(b.PerPost,1,4),  
	t.Acct,
	t.Sub, 
	BaseCuryID = t.BaseCuryID,
	BaseDecPl = c1.DecPl,
	CuryID = t.CuryID,
	CuryDecPl = c2.DecPl,
	t.LedgerID, 
	t.CpnyID,
	AcctType = MIN(RIGHT(RTRIM(a.AcctType),1)),
	Amount=	CASE MIN(RIGHT(RTRIM(a.AcctType),1))
		WHEN "A" THEN SUM(ROUND(t.DRAmt - t.CRAmt, c1.DecPl))
		WHEN "E" THEN SUM(ROUND(t.DRAmt - t.CRAmt, c1.DecPl))
		WHEN "L" THEN SUM(ROUND(t.CRAmt - t.DRAmt, c1.DecPl))
		WHEN "I" THEN SUM(ROUND(t.CRAmt - t.DRAmt, c1.DecPl))	
	END,
	CuryAmount=	CASE MIN(RIGHT(RTRIM(a.AcctType),1))
		WHEN "A" THEN SUM(ROUND(t.CuryDRAmt - t.CuryCRAmt, c2.DecPl))
		WHEN "E" THEN SUM(ROUND(t.CuryDRAmt - t.CuryCRAmt, c2.DecPl))
		WHEN "L" THEN SUM(ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl))
		WHEN "I" THEN SUM(ROUND(t.CuryCRAmt - t.CuryDRAmt, c2.DecPl))	
	END,
      UserAddress 
FROM GLTran t, Batch b, Account a, Currncy c1, Currncy c2,Wrkpost p
WHERE p.Batnbr = b.Batnbr AND p.Module = b.Module
  AND t.BatNbr = b.BatNbr AND t.Module = b.Module AND t.Acct = a.Acct 
  AND t.BaseCuryID = c1.CuryID AND t.CuryID = c2.CuryID 
GROUP BY b.PerPost, t.Acct, t.Sub, t.BaseCuryID, c1.DecPl, t.CuryID, c2.DecPl, t.FiscYr, 
t.LedgerID, t.CpnyID,UserAddress

 
