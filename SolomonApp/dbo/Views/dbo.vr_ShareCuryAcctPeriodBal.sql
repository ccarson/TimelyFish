 

CREATE VIEW vr_ShareCuryAcctPeriodBal AS

SELECT DISTINCT h.Acct, h.Sub, Period = RTrim(LTrim(h.FiscYr)) + v.Mon, v.Mon, h.fiscyr, 
	curyStart = CASE v.Mon 
		WHEN '01' THEN h.curyBegBal 
		WHEN '02' THEN h.curyYtdBal00
		WHEN '03' THEN h.curyYtdBal01
		WHEN '04' THEN h.curyYtdBal02
		WHEN '05' THEN h.curyYtdBal03
		WHEN '06' THEN h.curyYtdBal04
		WHEN '07' THEN h.curyYtdBal05
		WHEN '08' THEN h.curyYtdBal06
		WHEN '09' THEN h.curyYtdBal07
		WHEN '10' THEN h.curyYtdBal08
		WHEN '11' THEN h.curyYtdBal09
		WHEN '12' THEN h.curyYtdBal10
		WHEN '13' THEN h.curyYtdBal11
	END, curyFinish = CASE v.Mon 
		WHEN '01' THEN h.curyYtdBal00 
		WHEN '02' THEN h.curyYtdBal01
		WHEN '03' THEN h.curyYtdBal02
		WHEN '04' THEN h.curyYtdBal03
		WHEN '05' THEN h.curyYtdBal04
		WHEN '06' THEN h.curyYtdBal05
		WHEN '07' THEN h.curyYtdBal06
		WHEN '08' THEN h.curyYtdBal07
		WHEN '09' THEN h.curyYtdBal08
		WHEN '10' THEN h.curyYtdBal09
		WHEN '11' THEN h.curyYtdBal10
		WHEN '12' THEN h.curyYtdBal11
		WHEN '13' THEN h.curyYtdBal12
	END, curyActivity = CASE v.Mon
		WHEN '01' THEN h.curyPtdBal00 
		WHEN '02' THEN h.curyPtdBal01
		WHEN '03' THEN h.curyPtdBal02
		WHEN '04' THEN h.curyPtdBal03
		WHEN '05' THEN h.curyPtdBal04
		WHEN '06' THEN h.curyPtdBal05
		WHEN '07' THEN h.curyPtdBal06
		WHEN '08' THEN h.curyPtdBal07
		WHEN '09' THEN h.curyPtdBal08
		WHEN '10' THEN h.curyPtdBal09
		WHEN '11' THEN h.curyPtdBal10
		WHEN '12' THEN h.curyPtdBal11
		WHEN '13' THEN h.curyPtdBal12
	END, h.BalanceType, h.CuryID, h.LedgerID, 
	Ord = SUBSTRING(a.AcctType, 1, 1), a.Descr, a.AcctType, h.CpnyID, 
	NormVal = CASE WHEN SUBSTRING(a.AcctType, 2, 1) IN ("I", "L") THEN -1 ELSE 1 END 
FROM curyacct h, vr_ShareMonthList v, Account a, GLSetup s (NOLOCK)
WHERE h.Acct = a.Acct AND CONVERT(INT, v.Mon) <= CONVERT(INT, s.NbrPer)   


 
