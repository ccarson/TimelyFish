 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_01520PostTranMC AS

SELECT	Acct,
	Sub,
	FiscYr,
	BaseCuryID,
	BaseDecPl,
	CuryID,
	CuryDecPl,
	LedgerID,
	CpnyID,
	AcctType,
	Net00 = ROUND(SUM(CASE Period
		WHEN "01" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net01 = ROUND(SUM(CASE Period		WHEN "02" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net02 = ROUND(SUM(CASE Period
		WHEN "03" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net03 = ROUND(SUM(CASE Period
		WHEN "04" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net04 = ROUND(SUM(CASE Period
		WHEN "05" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net05 = ROUND(SUM(CASE Period
		WHEN "06" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net06 = ROUND(SUM(CASE Period
		WHEN "07" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net07 = ROUND(SUM(CASE Period
		WHEN "08" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net08 = ROUND(SUM(CASE Period
		WHEN "09" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net09 = ROUND(SUM(CASE Period
		WHEN "10" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net10 = ROUND(SUM(CASE Period
		WHEN "11" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net11 = ROUND(SUM(CASE Period
		WHEN "12" THEN Amount
		ELSE 0
	END), BaseDecPl),
	Net12 = ROUND(SUM(CASE Period
		WHEN "13" THEN Amount
		ELSE 0
	END), BaseDecPl),
	NetYear = ROUND(SUM(Amount), BaseDecPl),
	CuryNet00 = ROUND(SUM(CASE Period
		WHEN "01" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet01 = ROUND(SUM(CASE Period
		WHEN "02" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet02 = ROUND(SUM(CASE Period
		WHEN "03" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet03 = ROUND(SUM(CASE Period
		WHEN "04" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet04 = ROUND(SUM(CASE Period
		WHEN "05" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),	CuryNet05 = ROUND(SUM(CASE Period
		WHEN "06" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet06 = ROUND(SUM(CASE Period
		WHEN "07" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet07 = ROUND(SUM(CASE Period
		WHEN "08" THEN CuryAmount		ELSE 0
	END), CuryDecPl),
	CuryNet08 = ROUND(SUM(CASE Period
		WHEN "09" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet09 = ROUND(SUM(CASE Period
		WHEN "10" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet10 = ROUND(SUM(CASE Period
		WHEN "11" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet11 = ROUND(SUM(CASE Period
		WHEN "12" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNet12 = ROUND(SUM(CASE Period
		WHEN "13" THEN CuryAmount
		ELSE 0
	END), CuryDecPl),
	CuryNetYear = ROUND(SUM(CuryAmount), CuryDecPl),
      UserAddress

FROM	vp_01520GLTranMC
GROUP BY Acct, Sub, FiscYr, BaseCuryID, BaseDecPl, CuryID, CuryDecPl, 
         LedgerID,CpnyID, AcctType,UserAddress


 
