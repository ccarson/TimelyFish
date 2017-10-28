 

CREATE VIEW vp_01400CashDetail AS

SELECT t.CpnyId, t.Acct, t.Sub, t.PerPost, t.TranDate, 
	Disbursement = Sum(cramt)		,
	Receipt = sum(dramt),
	CuryDisbursement = Sum(CurycRamt),
	CuryReceipt = Sum(CuryDRamt),
        UserAddress
FROM GLTran t, WrkRelease w, CashAcct c, Ledger l, GLSetup s
WHERE w.Module = 'GL' AND t.module = w.module 
  and t.BatNbr = w.BatNbr 
  AND t.Acct = c.BankAcct 
  aND t.Sub = c.BankSub
  and t.cpnyid = c.cpnyid
  and l.ledgerid = t.ledgerid
  and l.BalanceType = 'A'
  and c.acceptglupdates = -1
  and t.LedgerID = s.LedgerID
GROUP BY t.CpnyId,t.Acct, t.Sub, t.PerPost, t.TranDate, UserAddress

 
