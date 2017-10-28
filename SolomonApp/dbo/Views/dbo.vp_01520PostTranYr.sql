 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_01520PostTranYr AS

SELECT	t.Acct,
	t.Sub,
	h.FiscYr,
	t.CuryID,
	t.DecPl,
	t.LedgerID,
	t.CpnyID,
	t.AcctType,

	Net00 = ROUND(SUM(CASE 
		WHEN t.Period = "01" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net01 = ROUND(SUM(CASE 
		WHEN t.Period = "02" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net02 = ROUND(SUM(CASE 
		WHEN t.Period = "03" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net03 = ROUND(SUM(CASE 
		WHEN t.Period = "04" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net04 = ROUND(SUM(CASE 
		WHEN t.Period = "05" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net05 = ROUND(SUM(CASE 
		WHEN t.Period = "06" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net06 = ROUND(SUM(CASE 
		WHEN t.Period = "07" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net07 = ROUND(SUM(CASE 
		WHEN t.Period = "08" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net08 = ROUND(SUM(CASE 
		WHEN t.Period = "09" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net09 = ROUND(SUM(CASE 
		WHEN t.Period = "10" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net10 = ROUND(SUM(CASE 
		WHEN t.Period = "11" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net11 = ROUND(SUM(CASE 
		WHEN t.Period = "12" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	Net12 = ROUND(SUM(CASE 
		WHEN t.Period = "13" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD00 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 1 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "01" AND SUBSTRING(s.PerNbr,5,2) >= "01" THEN t.Amount
		WHEN s.NbrPer >= 1 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "01" THEN t.Amount
		WHEN s.NbrPer >= 1 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "01") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD01 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 2 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "02" AND SUBSTRING(s.PerNbr,5,2) >= "02" THEN t.Amount
		WHEN s.NbrPer >= 2 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "02" THEN t.Amount
		WHEN s.NbrPer >= 2 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "02") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl), 
	YTD02 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 3 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "03" AND SUBSTRING(s.PerNbr,5,2) >= "03" THEN t.Amount
		WHEN s.NbrPer >= 3 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "03" THEN t.Amount
		WHEN s.NbrPer >= 3 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "03") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD03 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 4 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "04" AND SUBSTRING(s.PerNbr,5,2) >= "04" THEN t.Amount
		WHEN s.NbrPer >= 4 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "04" THEN t.Amount
		WHEN s.NbrPer >= 4 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "04") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD04 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 5 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "05" AND SUBSTRING(s.PerNbr,5,2) >= "05" THEN t.Amount
		WHEN s.NbrPer >= 5 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "05" THEN t.Amount
		WHEN s.NbrPer >= 5 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "05") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD05 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 6 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "06" AND SUBSTRING(s.PerNbr,5,2) >= "06" THEN t.Amount
		WHEN s.NbrPer >= 6 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "06" THEN t.Amount
		WHEN s.NbrPer >= 6 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "06") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD06 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 7 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "07" AND SUBSTRING(s.PerNbr,5,2) >= "07" THEN t.Amount
		WHEN s.NbrPer >= 7 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "07" THEN t.Amount
		WHEN s.NbrPer >= 7 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "07") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD07 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 8 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "08" AND SUBSTRING(s.PerNbr,5,2) >= "08" THEN t.Amount
		WHEN s.NbrPer >= 8 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "08" THEN t.Amount
		WHEN s.NbrPer >= 8 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "08") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD08 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 9 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "09" AND SUBSTRING(s.PerNbr,5,2) >= "09" THEN t.Amount
		WHEN s.NbrPer >= 9 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "09" THEN t.Amount
		WHEN s.NbrPer >= 9 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "09") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD09 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 10 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "10" AND SUBSTRING(s.PerNbr,5,2) >= "10" THEN t.Amount
		WHEN s.NbrPer >= 10 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "10" THEN t.Amount
		WHEN s.NbrPer >= 10 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "10") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD10 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 11 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "11" AND SUBSTRING(s.PerNbr,5,2) >= "11" THEN t.Amount
		WHEN s.NbrPer >= 11 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "11" THEN t.Amount
		WHEN s.NbrPer >= 11 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "11") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD11 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 12 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "12" AND SUBSTRING(s.PerNbr,5,2) >= "12" THEN t.Amount
		WHEN s.NbrPer >= 12 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "12" THEN t.Amount
		WHEN s.NbrPer >= 12 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "12") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),
	YTD12 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 13 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "13"  AND SUBSTRING(s.PerNbr,5,2) >= "13" THEN t.Amount
		WHEN s.NbrPer >= 13 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "13" THEN t.Amount
		WHEN s.NbrPer >= 13 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "13") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.DecPl),

	BegBal = ROUND(SUM(CASE
		WHEN t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") THEN t.Amount
		ELSE 0
	END), t.DecPl),
      UserAddress
FROM vp_01520GLTran t, AcctHist h, GLSetup s (NOLOCK)
WHERE t.Acct = h.Acct AND t.Sub = h.Sub AND t.LedgerID = h.LedgerID and t.CpnyID=h.CpnyID
GROUP BY t.Acct, t.Sub, h.FiscYr, t.CuryID, t.DecPl, t.LedgerID, t.CpnyID,t.AcctType,UserAddress



 
