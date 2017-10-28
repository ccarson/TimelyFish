create view BPv_AcctHist as

SELECT DISTINCT CpnyID, Acct, Sub, FiscYr
  FROM AcctHist
