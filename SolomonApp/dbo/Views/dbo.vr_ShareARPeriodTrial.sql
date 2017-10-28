 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vr_ShareARPeriodTrial AS

SELECT l.Period, s.ParentPerClosed, v.*, 
	Balance = CASE v.Ord WHEN 1 THEN s.Balance ELSE 0 END, 
	CurrBalance = CASE v.Ord WHEN 1 THEN s.CurrBalance ELSE 0 END	
FROM vr_ShareARCustDetail v INNER JOIN vr_SharePeriodListAR l ON v.PerPost <= l.Period LEFT JOIN
	vr_ShareARSum s ON l.Period = s.Period AND v.Parent = s.Parent AND
	v.CustID = s.CustID AND v.PDocType = s.PDocType
WHERE s.Parent IS NOT NULL OR v.Ord=2 AND v.PDocType='SC'

 
