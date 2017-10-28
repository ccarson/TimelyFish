 CREATE PROCEDURE AcctHist_RollUpByAcctSub @cpnyid varchar (10), @ledgerida varchar (10),  @ledgeridb varchar (10), @Acct varchar ( 10), @Sub varchar (24) , @Period varchar ( 6) AS
SELECT Period INTO #Periods from Periods
SELECT
h.CpnyId,
a.Acct,
MAX(a.AcctType) as AcctType,
MAX(a.Descr) as Descr,
h.Sub,
MAX(h.fiscyr)+Max(p.Period) as Period,
ActivityA = CONVERT(SmallInt, CASE WHEN Max(CASE WHEN h.LedgerId = @ledgerida THEN CASE
WHEN p.Period = '01' THEN h.PtdBal00
WHEN p.Period = '02' THEN h.PtdBal01
WHEN p.Period = '03' THEN h.PtdBal02
WHEN p.Period = '04' THEN h.PtdBal03
WHEN p.Period = '05' THEN h.PtdBal04
WHEN p.Period = '06' THEN h.PtdBal05
WHEN p.Period = '07' THEN h.PtdBal06
WHEN p.Period = '08' THEN h.PtdBal07
WHEN p.Period = '09' THEN h.PtdBal08
WHEN p.Period = '10' THEN h.PtdBal09
WHEN p.Period = '11' THEN h.PtdBal10
WHEN p.Period = '12' THEN h.PtdBal11
WHEN p.Period = '13' THEN h.PtdBal12
END ELSE 0 END)<> 0 THEN 1 ELSE 0 END),
BegBalA = Sum(CASE WHEN h.LedgerId = @ledgerida AND p.Period = '01' THEN h.BegBal ELSE 0 END),
YtdBalA = Sum(CASE WHEN h.LedgerId = @ledgerida THEN CASE
WHEN p.Period = '01' THEN h.PtdBal00
WHEN p.Period = '02' THEN h.PtdBal01
WHEN p.Period = '03' THEN h.PtdBal02
WHEN p.Period = '04' THEN h.PtdBal03
WHEN p.Period = '05' THEN h.PtdBal04
WHEN p.Period = '06' THEN h.PtdBal05
WHEN p.Period = '07' THEN h.PtdBal06
WHEN p.Period = '08' THEN h.PtdBal07
WHEN p.Period = '09' THEN h.PtdBal08
WHEN p.Period = '10' THEN h.PtdBal09
WHEN p.Period = '11' THEN h.PtdBal10
WHEN p.Period = '12' THEN h.PtdBal11
WHEN p.Period = '13' THEN h.PtdBal12
END ELSE 0 END),
YtdBalB = Sum(CASE WHEN h.LedgerId = @Ledgeridb THEN CASE
WHEN p.Period = '01' THEN h.PtdBal00
WHEN p.Period = '02' THEN h.PtdBal01
WHEN p.Period = '03' THEN h.PtdBal02
WHEN p.Period = '04' THEN h.PtdBal03
WHEN p.Period = '05' THEN h.PtdBal04
WHEN p.Period = '06' THEN h.PtdBal05
WHEN p.Period = '07' THEN h.PtdBal06
WHEN p.Period = '08' THEN h.PtdBal07
WHEN p.Period = '09' THEN h.PtdBal08
WHEN p.Period = '10' THEN h.PtdBal09
WHEN p.Period = '11' THEN h.PtdBal10
WHEN p.Period = '12' THEN h.PtdBal11
WHEN p.Period = '13' THEN h.PtdBal12
END ELSE 0 END),
User1 = MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User1 ELSE '' END),
User2 = MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User2 ELSE '' END),
User3 = COALESCE(MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User3 ELSE NULL END),0),
User4 = COALESCE(MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User4 ELSE NULL END),0),
User5 = MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User5 ELSE '' END),
User6 = MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User6 ELSE '' END),
User7 = MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User7 ELSE '' END),
User8 = MAX(CASE h.LedgerID WHEN @ledgerida THEN h.User8 ELSE '' END)
FROM Account a LEFT OUTER JOIN AcctHist h on a.acct = h.acct, #Periods p
WHERE
a.acct LIKE @acct AND
h.cpnyid = @cpnyid AND
(h.ledgerid = @ledgerida  OR h.ledgerid = @ledgeridb) AND
h.sub LIKE @sub AND
h.fiscyr = SUBSTRING(@period,1,4) AND
p.Period <= SUBSTRING(@period,5,2)
GROUP BY h.cpnyid, a.acct, h.sub
Order By h.cpnyid, a.acct, h.sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_RollUpByAcctSub] TO [MSDSL]
    AS [dbo];

