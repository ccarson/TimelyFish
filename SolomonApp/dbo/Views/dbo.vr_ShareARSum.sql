 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vr_ShareARSum AS

SELECT v.Parent, v.PDocType, v.CustID, l.Period, ParentPerClosed = MAX(CASE WHEN (v.Ord=1 AND v.PerClosed > "000000") THEN v.PerClosed ELSE "000000" END), 
	Balance = ROUND(SUM(v.OrigDocAmt), 6), CurrBalance = ROUND(SUM(v.CuryOrigDocAmt), 6)
FROM vr_ShareARDetail v, vr_SharePeriodListAR l
WHERE v.PerPost <= l.Period
GROUP BY v.Parent, v.PDocType, v.CustID, l.Period

 
