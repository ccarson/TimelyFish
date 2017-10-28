 


--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_SharePeriodListAR AS

SELECT DISTINCT Period = h.FiscYr + v.Mon 
FROM AcctHist h, vr_ShareMonthList v
UNION
SELECT SUBSTRING(CurrPerNbr,1,4) + v.Mon 
  FROM ARSetup, vr_ShareMonthList v

 
