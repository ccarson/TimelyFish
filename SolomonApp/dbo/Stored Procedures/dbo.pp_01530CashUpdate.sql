 CREATE	PROCEDURE pp_01530CashUpdate @BatNbr CHAR(10), @LineNbr SMALLINT

AS

INSERT	CashSumD (BankAcct, BankSub, ConCuryDisbursements, ConCuryReceipts,
	ConDisbursements, ConReceipts, CuryDisbursements, CuryID, CuryReceipts,
	Disbursements, NoteID, PerNbr, Receipts, TrANDate, User1, User2, User3, User4,
        CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User,
        LUpd_dateTime, LUpd_prog, LUpd_User,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
        User5, User6, User7, User8)
SELECT	t.Acct, t.Sub, 0, 0, 0, 0, 0, a.curyid, 0, 0, 0, t.PerPost, 0, t.TranDate, "", "", 0, 0,
        t.CpnyId, GETDATE(), '01530', t.Lupd_User, GETDATE(), '01530', t.Lupd_User,
        "", "", 0, 0, 0, 0, "", "", 0, 0, "", "", "", "", "", ""
FROM	GLTran t INNER JOIN CASetup s (NOLOCK) ON s.AcceptTransDate<=t.TranDate
	INNER JOIN GLSetup g (NOLOCK) ON g.UpdateCA=-1 INNER JOIN CashAcct a (NOLOCK) ON a.BankAcct=t.Acct
	AND a.BankSub=t.Sub AND a.CpnyID=t.CpnyID AND a.AcceptGLUpdates=-1
	LEFT JOIN CashSumD d ON d.BankAcct=t.Acct AND d.BankSub=t.Sub
	AND d.CpnyID=t.CpnyID AND d.TranDate=t.TranDate AND d.PerNbr=t.PerPost
WHERE	t.Module='GL' AND t.BatNbr=@BatNbr AND t.LineNbr=@LineNbr AND d.BankAcct IS NULL
IF @@ERROR <> 0 RETURN

UPDATE	CashSumD SET CuryDisbursements=ROUND(CuryDisbursements+t.CuryCrAmt, c2.DecPl),
	Disbursements=ROUND(Disbursements+t.CrAmt, c1.DecPl),
	CuryReceipts=ROUND(CuryReceipts+t.CuryDrAmt, c2.DecPl),
	Receipts=ROUND(Receipts+t.DrAmt, c1.DecPl),
	Lupd_Prog='01530', Lupd_User=t.Lupd_User, Lupd_DateTime=GETDATE()
FROM	GLTran t INNER JOIN CASetup s (NOLOCK) ON s.AcceptTransDate<=t.TranDate
	INNER JOIN GLSetup g (NOLOCK) ON g.UpdateCA=-1 INNER JOIN CashAcct a (NOLOCK) ON a.BankAcct=t.Acct
	AND a.BankSub=t.Sub AND a.CpnyID=t.CpnyID AND a.AcceptGLUpdates=-1
	INNER JOIN Currncy c1 (NOLOCK) ON c1.CuryID=g.BaseCuryID
	INNER JOIN Currncy c2 (NOLOCK) ON c2.CuryID=t.CuryID
WHERE	t.Module='GL' AND t.BatNbr=@BatNbr AND t.LineNbr=@LineNbr
	AND CashSumD.BankAcct=t.Acct AND CashSumD.BankSub=t.Sub AND CashSumD.CpnyID=t.CpnyID
	AND CashSumD.TranDate=t.TranDate AND CashSumD.PerNbr=t.PerPost


