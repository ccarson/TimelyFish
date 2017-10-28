 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_SharePeriodList AS

SELECT DISTINCT Period = h.FiscYr + v.Mon 
FROM AcctHist h, vr_ShareMonthList v





 
