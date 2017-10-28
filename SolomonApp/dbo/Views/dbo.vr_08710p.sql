 

CREATE	VIEW vr_08710p AS
SELECT	c.CustID, Name=c.Name,
	PtdSales1= CASE WHEN h1.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h1.PtdSales00-h1.PtdCrMemo00+h1.PtdDrMemo00
		WHEN '02' THEN h1.PtdSales01-h1.PtdCrMemo01+h1.PtdDrMemo01
		WHEN '03' THEN h1.PtdSales02-h1.PtdCrMemo02+h1.PtdDrMemo02
		WHEN '04' THEN h1.PtdSales03-h1.PtdCrMemo03+h1.PtdDrMemo03
		WHEN '05' THEN h1.PtdSales04-h1.PtdCrMemo04+h1.PtdDrMemo04
		WHEN '06' THEN h1.PtdSales05-h1.PtdCrMemo05+h1.PtdDrMemo05
		WHEN '07' THEN h1.PtdSales06-h1.PtdCrMemo06+h1.PtdDrMemo06
		WHEN '08' THEN h1.PtdSales07-h1.PtdCrMemo07+h1.PtdDrMemo07
		WHEN '09' THEN h1.PtdSales08-h1.PtdCrMemo08+h1.PtdDrMemo08
		WHEN '10' THEN h1.PtdSales09-h1.PtdCrMemo09+h1.PtdDrMemo09
		WHEN '11' THEN h1.PtdSales10-h1.PtdCrMemo10+h1.PtdDrMemo10
		WHEN '12' THEN h1.PtdSales11-h1.PtdCrMemo11+h1.PtdDrMemo11
		WHEN '13' THEN h1.PtdSales12-h1.PtdCrMemo12+h1.PtdDrMemo12
		ELSE 0 END ELSE 0 END,
	PtdSales2 = CASE WHEN h2.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h2.PtdSales00-h2.PtdCrMemo00+h2.PtdDrMemo00
		WHEN '02' THEN h2.PtdSales01-h2.PtdCrMemo01+h2.PtdDrMemo01
		WHEN '03' THEN h2.PtdSales02-h2.PtdCrMemo02+h2.PtdDrMemo02
		WHEN '04' THEN h2.PtdSales03-h2.PtdCrMemo03+h2.PtdDrMemo03
		WHEN '05' THEN h2.PtdSales04-h2.PtdCrMemo04+h2.PtdDrMemo04
		WHEN '06' THEN h2.PtdSales05-h2.PtdCrMemo05+h2.PtdDrMemo05
		WHEN '07' THEN h2.PtdSales06-h2.PtdCrMemo06+h2.PtdDrMemo06
		WHEN '08' THEN h2.PtdSales07-h2.PtdCrMemo07+h2.PtdDrMemo07
		WHEN '09' THEN h2.PtdSales08-h2.PtdCrMemo08+h2.PtdDrMemo08
		WHEN '10' THEN h2.PtdSales09-h2.PtdCrMemo09+h2.PtdDrMemo09
		WHEN '11' THEN h2.PtdSales10-h2.PtdCrMemo10+h2.PtdDrMemo10
		WHEN '12' THEN h2.PtdSales11-h2.PtdCrMemo11+h2.PtdDrMemo11
		WHEN '13' THEN h2.PtdSales12-h2.PtdCrMemo12+h2.PtdDrMemo12
		ELSE 0 END ELSE 0 END,
	YtdSales1= CASE WHEN h1.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h1.PtdSales00-h1.PtdCrMemo00+h1.PtdDrMemo00
		WHEN '02' THEN h1.PtdSales00+h1.PtdSales01-h1.PtdCrMemo00-h1.PtdCrMemo01+h1.PtdDrMemo00+h1.PtdDrMemo01
		WHEN '03' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02
		WHEN '04' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03
		WHEN '05' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04
		WHEN '06' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05
		WHEN '07' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05+h1.PtdSales06-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05-h1.PtdCrMemo06
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05+h1.PtdDrMemo06
		WHEN '08' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05+h1.PtdSales06+h1.PtdSales07-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05-h1.PtdCrMemo06-h1.PtdCrMemo07
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05+h1.PtdDrMemo06+h1.PtdDrMemo07
		WHEN '09' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05+h1.PtdSales06+h1.PtdSales07+h1.PtdSales08-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05-h1.PtdCrMemo06-h1.PtdCrMemo07-h1.PtdCrMemo08
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05+h1.PtdDrMemo06+h1.PtdDrMemo07+h1.PtdDrMemo08
		WHEN '10' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05+h1.PtdSales06+h1.PtdSales07+h1.PtdSales08+h1.PtdSales09-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05-h1.PtdCrMemo06-h1.PtdCrMemo07-h1.PtdCrMemo08-h1.PtdCrMemo09
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05+h1.PtdDrMemo06+h1.PtdDrMemo07+h1.PtdDrMemo08+h1.PtdDrMemo09
		WHEN '11' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05+h1.PtdSales06+h1.PtdSales07+h1.PtdSales08+h1.PtdSales09+h1.PtdSales10-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05-h1.PtdCrMemo06-h1.PtdCrMemo07-h1.PtdCrMemo08-h1.PtdCrMemo09-h1.PtdCrMemo10
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05+h1.PtdDrMemo06+h1.PtdDrMemo07+h1.PtdDrMemo08+h1.PtdDrMemo09+h1.PtdDrMemo10
		WHEN '12' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05+h1.PtdSales06+h1.PtdSales07+h1.PtdSales08+h1.PtdSales09+h1.PtdSales10+h1.PtdSales11-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05-h1.PtdCrMemo06-h1.PtdCrMemo07-h1.PtdCrMemo08-h1.PtdCrMemo09-h1.PtdCrMemo10-h1.PtdCrMemo11
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05+h1.PtdDrMemo06+h1.PtdDrMemo07+h1.PtdDrMemo08+h1.PtdDrMemo09+h1.PtdDrMemo10+h1.PtdDrMemo11
		WHEN '13' THEN h1.PtdSales00+h1.PtdSales01+h1.PtdSales02+h1.PtdSales03+h1.PtdSales04+h1.PtdSales05+h1.PtdSales06+h1.PtdSales07+h1.PtdSales08+h1.PtdSales09+h1.PtdSales10+h1.PtdSales11+h1.PtdSales12-h1.PtdCrMemo00-h1.PtdCrMemo01-h1.PtdCrMemo02-h1.PtdCrMemo03-h1.PtdCrMemo04-h1.PtdCrMemo05-h1.PtdCrMemo06-h1.PtdCrMemo07-h1.PtdCrMemo08-h1.PtdCrMemo09-h1.PtdCrMemo10-h1.PtdCrMemo11-h1.PtdCrMemo12
		+h1.PtdDrMemo00+h1.PtdDrMemo01+h1.PtdDrMemo02+h1.PtdDrMemo03+h1.PtdDrMemo04+h1.PtdDrMemo05+h1.PtdDrMemo06+h1.PtdDrMemo07+h1.PtdDrMemo08+h1.PtdDrMemo09+h1.PtdDrMemo10+h1.PtdDrMemo11+h1.PtdDrMemo12
		ELSE 0 END ELSE 0 END,
	YtdSales2=CASE WHEN h2.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h2.PtdSales00-h2.PtdCrMemo00+h2.PtdDrMemo00
		WHEN '02' THEN h2.PtdSales00+h2.PtdSales01-h2.PtdCrMemo00-h2.PtdCrMemo01
		+h2.PtdDrMemo00+h2.PtdDrMemo01
		WHEN '03' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02
		WHEN '04' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03
		WHEN '05' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04
		WHEN '06' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05
		WHEN '07' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05+h2.PtdSales06-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05-h2.PtdCrMemo06
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05+h2.PtdDrMemo06
		WHEN '08' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05+h2.PtdSales06+h2.PtdSales07-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05-h2.PtdCrMemo06-h2.PtdCrMemo07
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05+h2.PtdDrMemo06+h2.PtdDrMemo07
		WHEN '09' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05+h2.PtdSales06+h2.PtdSales07+h2.PtdSales08-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05-h2.PtdCrMemo06-h2.PtdCrMemo07-h2.PtdCrMemo08
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05+h2.PtdDrMemo06+h2.PtdDrMemo07+h2.PtdDrMemo08
		WHEN '10' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05+h2.PtdSales06+h2.PtdSales07+h2.PtdSales08+h2.PtdSales09-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05-h2.PtdCrMemo06-h2.PtdCrMemo07-h2.PtdCrMemo08-h2.PtdCrMemo09
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05+h2.PtdDrMemo06+h2.PtdDrMemo07+h2.PtdDrMemo08+h2.PtdDrMemo09
		WHEN '11' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05+h2.PtdSales06+h2.PtdSales07+h2.PtdSales08+h2.PtdSales09+h2.PtdSales10-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05-h2.PtdCrMemo06-h2.PtdCrMemo07-h2.PtdCrMemo08-h2.PtdCrMemo09-h2.PtdCrMemo10
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05+h2.PtdDrMemo06+h2.PtdDrMemo07+h2.PtdDrMemo08+h2.PtdDrMemo09+h2.PtdDrMemo10
		WHEN '12' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05+h2.PtdSales06+h2.PtdSales07+h2.PtdSales08+h2.PtdSales09+h2.PtdSales10+h2.PtdSales11-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05-h2.PtdCrMemo06-h2.PtdCrMemo07-h2.PtdCrMemo08-h2.PtdCrMemo09-h2.PtdCrMemo10-h2.PtdCrMemo11
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05+h2.PtdDrMemo06+h2.PtdDrMemo07+h2.PtdDrMemo08+h2.PtdDrMemo09+h2.PtdDrMemo10+h2.PtdDrMemo11
		WHEN '13' THEN h2.PtdSales00+h2.PtdSales01+h2.PtdSales02+h2.PtdSales03+h2.PtdSales04+h2.PtdSales05+h2.PtdSales06+h2.PtdSales07+h2.PtdSales08+h2.PtdSales09+h2.PtdSales10+h2.PtdSales11+h2.PtdSales12-h2.PtdCrMemo00-h2.PtdCrMemo01-h2.PtdCrMemo02-h2.PtdCrMemo03-h2.PtdCrMemo04-h2.PtdCrMemo05-h2.PtdCrMemo06-h2.PtdCrMemo07-h2.PtdCrMemo08-h2.PtdCrMemo09-h2.PtdCrMemo10-h2.PtdCrMemo11-h2.PtdCrMemo12
		+h2.PtdDrMemo00+h2.PtdDrMemo01+h2.PtdDrMemo02+h2.PtdDrMemo03+h2.PtdDrMemo04+h2.PtdDrMemo05+h2.PtdDrMemo06+h2.PtdDrMemo07+h2.PtdDrMemo08+h2.PtdDrMemo09+h2.PtdDrMemo10+h2.PtdDrMemo11+h2.PtdDrMemo12
		ELSE 0 END ELSE 0 END,
	PtdCOGS1=CASE WHEN h1.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h1.PtdCOGS00
		WHEN '02' THEN h1.PtdCOGS01
		WHEN '03' THEN h1.PtdCOGS02
		WHEN '04' THEN h1.PtdCOGS03
		WHEN '05' THEN h1.PtdCOGS04
		WHEN '06' THEN h1.PtdCOGS05
		WHEN '07' THEN h1.PtdCOGS06
		WHEN '08' THEN h1.PtdCOGS07
		WHEN '09' THEN h1.PtdCOGS08
		WHEN '10' THEN h1.PtdCOGS09
		WHEN '11' THEN h1.PtdCOGS10
		WHEN '12' THEN h1.PtdCOGS11
		WHEN '13' THEN h1.PtdCOGS12
		ELSE 0 END ELSE 0 END,
	PtdCOGS2=CASE WHEN h2.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h2.PtdCOGS00
		WHEN '02' THEN h2.PtdCOGS01
		WHEN '03' THEN h2.PtdCOGS02
		WHEN '04' THEN h2.PtdCOGS03
		WHEN '05' THEN h2.PtdCOGS04
		WHEN '06' THEN h2.PtdCOGS05
		WHEN '07' THEN h2.PtdCOGS06
		WHEN '08' THEN h2.PtdCOGS07
		WHEN '09' THEN h2.PtdCOGS08
		WHEN '10' THEN h2.PtdCOGS09
		WHEN '11' THEN h2.PtdCOGS10
		WHEN '12' THEN h2.PtdCOGS11
		WHEN '13' THEN h2.PtdCOGS12
		ELSE 0 END ELSE 0 END,
	YtdCOGS1=CASE WHEN h1.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h1.PtdCOGS00
		WHEN '02' THEN h1.PtdCOGS00+h1.PtdCOGS01
		WHEN '03' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02
		WHEN '04' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03
		WHEN '05' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04
		WHEN '06' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05
		WHEN '07' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05+h1.PtdCOGS06
		WHEN '08' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05+h1.PtdCOGS06+h1.PtdCOGS07
		WHEN '09' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05+h1.PtdCOGS06+h1.PtdCOGS07+h1.PtdCOGS08
		WHEN '10' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05+h1.PtdCOGS06+h1.PtdCOGS07+h1.PtdCOGS08+h1.PtdCOGS09
		WHEN '11' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05+h1.PtdCOGS06+h1.PtdCOGS07+h1.PtdCOGS08+h1.PtdCOGS09+h1.PtdCOGS10
		WHEN '12' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05+h1.PtdCOGS06+h1.PtdCOGS07+h1.PtdCOGS08+h1.PtdCOGS09+h1.PtdCOGS10+h1.PtdCOGS11
		WHEN '13' THEN h1.PtdCOGS00+h1.PtdCOGS01+h1.PtdCOGS02+h1.PtdCOGS03+h1.PtdCOGS04+h1.PtdCOGS05+h1.PtdCOGS06+h1.PtdCOGS07+h1.PtdCOGS08+h1.PtdCOGS09+h1.PtdCOGS10+h1.PtdCOGS11+h1.PtdCOGS12
		ELSE 0 END ELSE 0 END,
	YtdCOGS2=CASE WHEN h2.CustID IS NOT NULL THEN CASE r.Period WHEN '01' THEN h2.PtdCOGS00
		WHEN '02' THEN h2.PtdCOGS00+h2.PtdCOGS01
		WHEN '03' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02
		WHEN '04' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03
		WHEN '05' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04
		WHEN '06' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05
		WHEN '07' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05+h2.PtdCOGS06
		WHEN '08' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05+h2.PtdCOGS06+h2.PtdCOGS07
		WHEN '09' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05+h2.PtdCOGS06+h2.PtdCOGS07+h2.PtdCOGS08
		WHEN '10' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05+h2.PtdCOGS06+h2.PtdCOGS07+h2.PtdCOGS08+h2.PtdCOGS09
		WHEN '11' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05+h2.PtdCOGS06+h2.PtdCOGS07+h2.PtdCOGS08+h2.PtdCOGS09+h2.PtdCOGS10
		WHEN '12' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05+h2.PtdCOGS06+h2.PtdCOGS07+h2.PtdCOGS08+h2.PtdCOGS09+h2.PtdCOGS10+h2.PtdCOGS11
		WHEN '13' THEN h2.PtdCOGS00+h2.PtdCOGS01+h2.PtdCOGS02+h2.PtdCOGS03+h2.PtdCOGS04+h2.PtdCOGS05+h2.PtdCOGS06+h2.PtdCOGS07+h2.PtdCOGS08+h2.PtdCOGS09+h2.PtdCOGS10+h2.PtdCOGS11+h2.PtdCOGS12
		ELSE 0 END ELSE 0 END, r.RI_ID,
       	c.User1 as CustUser1, c.User2 as CustUser2, c.User3 as CustUser3, c.User4 as CustUser4,
       	c.User5 as CustUser5, c.User6 as CustUser6, c.User7 as CustUser7, c.User8 as CustUser8
FROM	(SELECT RI_ID, CurrYr=SUBSTRING(EndPerNbr,1,4), PrevYr=CONVERT(CHAR(4),CONVERT(INT,SUBSTRING(EndPerNbr,1,4))-1),
		Period=SUBSTRING(EndPerNbr,5,2), ReportName, CpnyID FROM RptRuntime ) r 
	INNER JOIN Customer c ON left(r.ReportName, 6) ='08710p' 
	LEFT OUTER JOIN ARHist h2 ON h2.CustID=c.CustID AND h2.FiscYr=r.CurrYr AND h2.CpnyID = r.CpnyID
	LEFT JOIN ARHist h1 ON h1.CustID=c.CustID AND h1.FiscYr=r.PrevYr AND h1.CpnyID=r.CpnyID
WHERE h1.CustID IS NOT NULL OR h2.CustID IS NOT NULL


 
