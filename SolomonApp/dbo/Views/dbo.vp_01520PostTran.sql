 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_01520PostTran AS 

SELECT	Acct,
	Sub,
	FiscYr,
	CuryID,
	DecPl,
	LedgerID,
	CpnyID,
	AcctType,
	Net00 = ROUND(SUM(CASE Period
		WHEN "01" THEN Amount
		ELSE 0
	END), DecPl),
	Net01 = ROUND(SUM(CASE Period
		WHEN "02" THEN Amount
		ELSE 0
	END), DecPl),
	Net02 = ROUND(SUM(CASE Period
		WHEN "03" THEN Amount
		ELSE 0
	END), DecPl),
	Net03 = ROUND(SUM(CASE Period
		WHEN "04" THEN Amount
		ELSE 0
	END), DecPl),
	Net04 = ROUND(SUM(CASE Period
		WHEN "05" THEN Amount
		ELSE 0
	END), DecPl),
	Net05 = ROUND(SUM(CASE Period
		WHEN "06" THEN Amount
		ELSE 0
	END), DecPl),
	Net06 = ROUND(SUM(CASE Period
		WHEN "07" THEN Amount
		ELSE 0
	END), DecPl),
	Net07 = ROUND(SUM(CASE Period
		WHEN "08" THEN Amount
		ELSE 0
	END), DecPl),
	Net08 = ROUND(SUM(CASE Period
		WHEN "09" THEN Amount
		ELSE 0
	END), DecPl),
	Net09 = ROUND(SUM(CASE Period
		WHEN "10" THEN Amount
		ELSE 0
	END), DecPl),
	Net10 = ROUND(SUM(CASE Period
		WHEN "11" THEN Amount
		ELSE 0
	END), DecPl),
	Net11 = ROUND(SUM(CASE Period
		WHEN "12" THEN Amount
		ELSE 0
	END), DecPl),
	Net12 = ROUND(SUM(CASE Period
		WHEN "13" THEN Amount
		ELSE 0
	END), DecPl),
	NetYear = ROUND(SUM(Amount), DecPl),
      UserAddress
FROM	vp_01520GLTran
GROUP BY Acct, Sub, FiscYr, CuryID, DecPl, LedgerID, CpnyID,AcctType, UserAddress

 
