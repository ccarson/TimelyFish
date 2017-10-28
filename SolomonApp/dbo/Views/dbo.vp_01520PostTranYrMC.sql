 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_01520PostTranYrMC AS


SELECT	t.Acct,
	t.Sub,
	h.FiscYr,
	t.CuryID,
	t.LedgerID,
	t.CpnyID,
	t.AcctType,
	Net00 = ROUND(SUM(CASE 
		WHEN t.Period = "01" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net01 = ROUND(SUM(CASE 
		WHEN t.Period = "02" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net02 = ROUND(SUM(CASE 
		WHEN t.Period = "03" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net03 = ROUND(SUM(CASE 
		WHEN t.Period = "04" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net04 = ROUND(SUM(CASE 
		WHEN t.Period = "05" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net05 = ROUND(SUM(CASE 
		WHEN t.Period = "06" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net06 = ROUND(SUM(CASE 
		WHEN t.Period = "07" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net07 = ROUND(SUM(CASE 
		WHEN t.Period = "08" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net08 = ROUND(SUM(CASE 
		WHEN t.Period = "09" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net09 = ROUND(SUM(CASE 
		WHEN t.Period = "10" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net10 = ROUND(SUM(CASE 
		WHEN t.Period = "11" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	Net11 = ROUND(SUM(CASE 
		WHEN t.Period = "12" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0

	END), t.BaseDecPl),
	Net12 = ROUND(SUM(CASE 
		WHEN t.Period = "13" AND t.FiscYr = h.FiscYr THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	CuryNet00 = ROUND(SUM(CASE 
		WHEN t.Period = "01" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet01 = ROUND(SUM(CASE 
		WHEN t.Period = "02" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet02 = ROUND(SUM(CASE 
		WHEN t.Period = "03" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet03 = ROUND(SUM(CASE 
		WHEN t.Period = "04" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet04 = ROUND(SUM(CASE 
		WHEN t.Period = "05" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet05 = ROUND(SUM(CASE 
		WHEN t.Period = "06" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet06 = ROUND(SUM(CASE 
		WHEN t.Period = "07" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet07 = ROUND(SUM(CASE 
		WHEN t.Period = "08" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet08 = ROUND(SUM(CASE 
		WHEN t.Period = "09" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet09 = ROUND(SUM(CASE 
		WHEN t.Period = "10" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet10 = ROUND(SUM(CASE 
		WHEN t.Period = "11" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet11 = ROUND(SUM(CASE 
		WHEN t.Period = "12" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryNet12 = ROUND(SUM(CASE 
		WHEN t.Period = "13" AND t.FiscYr = h.FiscYr THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	YTD00 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 1 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "01" AND SUBSTRING(s.PerNbr,5,2) >= "01" THEN t.Amount
		WHEN s.NbrPer >= 1 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "01" THEN t.Amount
		WHEN s.NbrPer >= 1 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "01") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD01 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 2 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "02" AND SUBSTRING(s.PerNbr,5,2) >= "02" THEN t.Amount
		WHEN s.NbrPer >= 2 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "02" THEN t.Amount
		WHEN s.NbrPer >= 2 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "02") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl), 
	YTD02 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 3 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "03" AND SUBSTRING(s.PerNbr,5,2) >= "03" THEN t.Amount
		WHEN s.NbrPer >= 3 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "03" THEN t.Amount
		WHEN s.NbrPer >= 3 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "03") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD03 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 4 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "04" AND SUBSTRING(s.PerNbr,5,2) >= "04" THEN t.Amount
		WHEN s.NbrPer >= 4 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "04" THEN t.Amount
		WHEN s.NbrPer >= 4 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "04") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD04 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 5 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "05" AND SUBSTRING(s.PerNbr,5,2) >= "05" THEN t.Amount
		WHEN s.NbrPer >= 5 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "05" THEN t.Amount
		WHEN s.NbrPer >= 5 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "05") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD05 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 6 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "06" AND SUBSTRING(s.PerNbr,5,2) >= "06" THEN t.Amount
		WHEN s.NbrPer >= 6 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "06" THEN t.Amount
		WHEN s.NbrPer >= 6 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "06") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD06 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 7 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "07" AND SUBSTRING(s.PerNbr,5,2) >= "07" THEN t.Amount
		WHEN s.NbrPer >= 7 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "07" THEN t.Amount
		WHEN s.NbrPer >= 7 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "07") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD07 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 8 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "08" AND SUBSTRING(s.PerNbr,5,2) >= "08" THEN t.Amount
		WHEN s.NbrPer >= 8 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "08" THEN t.Amount
		WHEN s.NbrPer >= 8 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "08") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD08 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 9 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "09" AND SUBSTRING(s.PerNbr,5,2) >= "09" THEN t.Amount
		WHEN s.NbrPer >= 9 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "09" THEN t.Amount
		WHEN s.NbrPer >= 9 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "09") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD09 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 10 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "10" AND SUBSTRING(s.PerNbr,5,2) >= "10" THEN t.Amount
		WHEN s.NbrPer >= 10 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "10" THEN t.Amount
		WHEN s.NbrPer >= 10 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "10") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD10 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 11 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "11" AND SUBSTRING(s.PerNbr,5,2) >= "11" THEN t.Amount
		WHEN s.NbrPer >= 11 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "11" THEN t.Amount
		WHEN s.NbrPer >= 11 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "11") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD11 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 12 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "12" AND SUBSTRING(s.PerNbr,5,2) >= "12" THEN t.Amount
		WHEN s.NbrPer >= 12 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "12" THEN t.Amount
		WHEN s.NbrPer >= 12 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "12") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	YTD12 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 13 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "13" AND SUBSTRING(s.PerNbr,5,2) >= "13" THEN t.Amount
		WHEN s.NbrPer >= 13 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "13" THEN t.Amount
		WHEN s.NbrPer >= 13 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "13") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	BegBal = ROUND(SUM(CASE
		WHEN t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") THEN t.Amount
		ELSE 0
	END), t.BaseDecPl),
	CuryYTD00 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 1 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "01" AND SUBSTRING(s.PerNbr,5,2) >= "01" THEN t.CuryAmount
		WHEN s.NbrPer >= 1 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "01" THEN t.CuryAmount
		WHEN s.NbrPer >= 1 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "01") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD01 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 2 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "02" AND SUBSTRING(s.PerNbr,5,2) >= "02" THEN t.CuryAmount
		WHEN s.NbrPer >= 2 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "02" THEN t.CuryAmount
		WHEN s.NbrPer >= 2 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "02") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl), 
	CuryYTD02 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 3 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "03" AND SUBSTRING(s.PerNbr,5,2) >= "03" THEN t.CuryAmount
		WHEN s.NbrPer >= 3 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "03" THEN t.CuryAmount
		WHEN s.NbrPer >= 3 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "03") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD03 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 4 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "04" AND SUBSTRING(s.PerNbr,5,2) >= "04" THEN t.CuryAmount
		WHEN s.NbrPer >= 4 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "04" THEN t.CuryAmount
		WHEN s.NbrPer >= 4 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "04") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD04 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 5 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "05" AND SUBSTRING(s.PerNbr,5,2) >= "05" THEN t.CuryAmount
		WHEN s.NbrPer >= 5 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "05" THEN t.CuryAmount
		WHEN s.NbrPer >= 5 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "05") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD05 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 6 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "06" AND SUBSTRING(s.PerNbr,5,2) >= "06" THEN t.CuryAmount
		WHEN s.NbrPer >= 6 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "06" THEN t.CuryAmount
		WHEN s.NbrPer >= 6 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "06") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD06 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 7 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "07" AND SUBSTRING(s.PerNbr,5,2) >= "07" THEN t.CuryAmount
		WHEN s.NbrPer >= 7 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "07" THEN t.CuryAmount
		WHEN s.NbrPer >= 7 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "07") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD07 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 8 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "08" AND SUBSTRING(s.PerNbr,5,2) >= "08" THEN t.CuryAmount
		WHEN s.NbrPer >= 8 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "08" THEN t.CuryAmount
		WHEN s.NbrPer >= 8 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "08") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD08 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 9 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "09" AND SUBSTRING(s.PerNbr,5,2) >= "09" THEN t.CuryAmount
		WHEN s.NbrPer >= 9 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "09" THEN t.CuryAmount
		WHEN s.NbrPer >= 9 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "09") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD09 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 10 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "10" AND SUBSTRING(s.PerNbr,5,2) >= "10" THEN t.CuryAmount
		WHEN s.NbrPer >= 10 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "10" THEN t.CuryAmount
		WHEN s.NbrPer >= 10 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "10") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD10 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 11 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "11" AND SUBSTRING(s.PerNbr,5,2) >= "11" THEN t.CuryAmount
		WHEN s.NbrPer >= 11 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "11" THEN t.CuryAmount
		WHEN s.NbrPer >= 11 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "11") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD11 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 12 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "12" AND SUBSTRING(s.PerNbr,5,2) >= "12" THEN t.CuryAmount
		WHEN s.NbrPer >= 12 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "12" THEN t.CuryAmount
		WHEN s.NbrPer >= 12 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "12") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryYTD12 = ROUND(SUM(CASE
		WHEN s.NbrPer >= 13 AND t.FiscYr = h.FiscYr AND t.FiscYr = SUBSTRING(s.PerNbr,1,4) AND t.Period <= "13" AND SUBSTRING(s.PerNbr,5,2) >= "13" THEN t.CuryAmount
		WHEN s.NbrPer >= 13 AND t.FiscYr = h.FiscYr AND t.FiscYr < SUBSTRING(s.PerNbr,1,4) AND t.Period <= "13" THEN t.CuryAmount
		WHEN s.NbrPer >= 13 AND t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") AND 
			((h.FiscYr = SUBSTRING(s.PerNbr,1,4) AND SUBSTRING(s.PerNbr,5,2) >= "13") OR h.FiscYr < SUBSTRING(s.PerNbr,1,4)) THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
	CuryBegBal = ROUND(SUM(CASE
		WHEN t.FiscYr < h.FiscYr AND t.AcctType IN ("A", "L") THEN t.CuryAmount
		ELSE 0
	END), t.CuryDecPl),
      UserADDress
FROM vp_01520GLTranMC t, CuryAcct h, GLSetup s (NOLOCK)
WHERE t.Acct = h.Acct AND t.Sub = h.Sub AND t.LedgerID = h.LedgerID AND t.CuryID = h.CuryID
And t.CpnyID=h.CpnyID 
GROUP BY t.Acct, t.Sub, h.FiscYr, t.CuryID, t.BaseDecPl, t.CuryDecPl, t.LedgerID,t.CpnyID, t.AcctType, UserADdress


 
