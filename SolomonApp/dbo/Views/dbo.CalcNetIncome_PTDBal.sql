CREATE VIEW CalcNetIncome_PTDBal
	AS
select CpnyID, FiscYr, Sub, 
	PTDBal00 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal00 
		ELSE h.ptdbal00 * -1 END),
	PTDBal01 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal01 
		ELSE h.ptdbal01 * -1 END),
	PTDBal02 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal02
		ELSE h.ptdbal02 * -1 END),
	PTDBal03 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal03
		ELSE h.ptdbal03 * -1 END),
	PTDBal04 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal04
		ELSE h.ptdbal04 * -1 END),
	PTDBal05 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal05
		ELSE h.ptdbal05 * -1 END),
	PTDBal06 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal06
		ELSE h.ptdbal06 * -1 END),
	PTDBal07 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal07
		ELSE h.ptdbal07 * -1 END),
	PTDBal08 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal08
		ELSE h.ptdbal08 * -1 END),
	PTDBal09 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal09
		ELSE h.ptdbal09 * -1 END),
	PTDBal10 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal10
		ELSE h.ptdbal10 * -1 END),
	PTDBal11 = Sum(CASE a.AcctType WHEN '3I' THEN h.ptdbal11
		ELSE h.ptdbal11 * -1 END)
	from accthist h
	join account a ON h.Acct = a.Acct
	where h.fiscyr = '2005' and a.AcctType IN('3I','3E')
	GROUP By CpnyID, FiscYr, Sub
