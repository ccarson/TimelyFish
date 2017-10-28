 CREATE PROCEDURE pp_01400_Cash_BankRec
	@BatNbr char(10),
	@Module char(2)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
SELECT t.* FROM GLTran t
INNER JOIN CashAcct a ON t.Acct = a.BankAcct AND t.CpnyID = a.CpnyID AND t.Sub = a.BankSub AND a.Active = 1 AND a.AcceptGLUpdates = -1
INNER JOIN BankRec b ON a.BankAcct = b.BankAcct AND a.BankSub = b.BankSub AND a.CpnyID = b.CpnyID /*AND b.ReconcileFlag = -1*/ AND b.StmtDate >= t.S4Future07
INNER JOIN CASetup s ON s.AcceptTransDate <= t.TranDate
WHERE t.S4Future11 = 'C' AND t.BatNbr = @BatNbr AND t.Module = @Module


