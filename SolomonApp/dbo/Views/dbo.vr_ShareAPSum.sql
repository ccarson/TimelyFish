 

--APPTABLE
--USETHISSYNTAX

/****** Last Modified by Phat Ho on 7/29/98 ******/

CREATE VIEW vr_ShareAPSum AS

SELECT v.Parent, v.ParentType, ParentPerClosed = MAX(CASE WHEN (v.Ord=1 AND v.PerClosed > "000000") THEN v.PerClosed ELSE "000000" END), l.Period, Balance = ROUND(SUM(v.OrigDocAmt), 6), 
	CurrBalance = ROUND(SUM(v.CuryOrigDocAmt), 6), ParentOrd = MIN(v.Ord)
FROM vr_ShareAPDetail v, vr_SharePeriodList l
WHERE v.PerPost <= l.Period
GROUP BY v.Parent, v.ParentType, l.Period

 
