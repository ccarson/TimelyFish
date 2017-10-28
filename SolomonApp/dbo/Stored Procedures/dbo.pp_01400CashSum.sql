 CREATE PROCEDURE pp_01400CashSum @UserAddress VARCHAR(21), @ProgId CHAR(8), @Sol_User CHAR(10), @Result INT OUTPUT
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

declare @basedecpl SMALLINT
declare @cashdate smalldatetime

declare @CpnyID VARCHAR (10)
declare @BankAcct VARCHAR(10)
declare @BankSub VARCHAR ( 24)
declare @TranDate SMALLDATETIME
declare @ClearDate SMALLDATETIME
declare @DrAmt FLOAT (8)
declare @CrAmt FLOAT (8)
declare @CuryDrAmt FLOAT (8)
declare @CuryCrAmt FLOAT (8)
declare @Status  VARCHAR (1)
declare @GLSetupLedgerID  VARCHAR (10)

declare @DrCr VARCHAR (1)
declare @TranAmt FLOAT (8)
declare @CuryTranAmt FLOAT (8)

CREATE	TABLE #TempAvgD (CpnyID CHAR(10), Acct CHAR(10), Sub CHAR(24),
			 InsPer CHAR(6), MinPer CHAR(6), MaxPer CHAR(6),
			 CuryAmt FLOAT, Amt FLOAT,
			 CuryChk FLOAT, Chk FLOAT, CuryDep FLOAT, Dep FLOAT,
			 NbrChk INT, NbrDep INT,
			 ChkDays INT, DepDays INT)
IF @@ERROR <> 0 GOTO Abort

DECLARE	@CuryDecPl	SMALLINT
DECLARE	@MinPer		CHAR(6)
DECLARE	@MaxPer		CHAR(6)
DECLARE	@PrvPer		CHAR(6)
DECLARE	@NbrPer		SMALLINT

select @cashdate = accepttransdate from casetup
select @basedecpl = coalesce(c.decpl, 0), @GLSetupLedgerID = s.LedgerID, @NbrPer = s.NbrPer from glsetup s  (nolock) left join currncy c (nolock) on s.basecuryid = c.curyid
IF @NbrPer IS NULL GOTO Abort

if @cashdate is not null
BEGIN

	INSERT CashSumD (BankAcct, BankSub, ConCuryDisbursements, ConCuryReceipts,
		ConDisbursements, ConReceipts, CuryDisbursements, CuryID, CuryReceipts,
		Disbursements, NoteID, PerNbr, Receipts, TrANDate, User1, User2, User3, User4,
        	CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User,
        	LUpd_dateTime, LUpd_prog, LUpd_User,
        	S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        	S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
        	User5, User6, User7, User8)
 	SELECT t.Acct, t.Sub, 0, 0, 0, 0, 0, a.curyid, 0, 0, 0, t.PerPost, 0, t.TrANDate, '', '', 0, 0,
        	t.CpnyId, GETDATE(), @ProgID, @Sol_User, GETDATE(), @ProgID, @Sol_User,
        	'', '', 0, 0, 0, 0, '', '', 0, 0, '', '', '', '', '', ''
   	FROM    cashacct a,vp_01400CashDetail t LEFT OUTER JOIN CashSumD d
		ON t.Acct = d.BankAcct AND t.Sub = d.BankSub AND t.PerPost = d.PerNbr AND
		t.TrANDate = d.TrANDate and t.cpnyid = d.cpnyid
	WHERE d.BankAcct IS NULL
      		AND UserAddress = @Useraddress and t.cpnyid = a.cpnyid and t.Acct = a.BankAcct AND t.Sub = a.BankSub and t.trandate >= @cashdate

	IF @@ERROR < > 0 GOTO ABORT

	UPDATE d Set @CuryDecPl = c.DecPl,
		d.CuryDisbursements =
		ROUND(d.CuryDisbursements + v.CuryDisbursement, c.decpl),
		d.Disbursements =
		ROUND(d.Disbursements + v.Disbursement, @basedecpl),
		d.Receipts =
		ROUND(d.Receipts + v.Receipt, @basedecpl),
        	d.CuryReceipts =
	        ROUND(d.CuryReceipts + v.CuryReceipt, c.decpl)
   	FROM vp_01400CashDetail v, CashSumD d, Currncy c
  	WHERE v.Acct = d.BankAcct AND v.Sub = d.BankSub AND v.PerPost = d.PerNbr AND
		v.TranDate = d.TranDate and v.cpnyid = d.cpnyid and d.curyid = c.curyid AND UserAddress = @Useraddress and v.trandate >= @cashdate

	IF @@ERROR < > 0 GOTO ABORT
		Update g
	Set g.S4future11 = 'N', g.S4Future03 = 0, g.S4Future07 = ''
	From  WrkRelease w
		INNER JOIN GLTran g ON w.BatNbr = g.BatNbr and w.module = g.module
		INNER JOIN Ledger l ON l.LedgerID = g.LedgerID
		LEFT OUTER JOIN CashAcct c ON g.CpnyID = c.CpnyID
			AND g.Acct = c.BankAcct AND g.Sub = c.BankSub

	WHERE
 		(COALESCE(c.acceptglupdates,0) = 0 OR l.BalanceType <> 'A' OR g.LedgerID <> @GLSetupLedgerID)
		and w.Module = 'GL'
		and w.UserAddress = @UserAddress

	IF @@ERROR < > 0 GOTO ABORT

  	DECLARE RGLTranCursor CURSOR FOR
		SELECT t.CpnyID, t.Acct, t.Sub, t.TranDate, t.S4Future07, t.DrAmt, t.CrAmt, t.CuryDrAmt, t.CuryCrAmt, t.S4Future11
		FROM WrkRelease w, GLTran t
	 WHERE w.UserAddress = @UserAddress
           AND w.BatNbr = t.BatNbr
           AND w.Module = t.Module
           AND t.Module = 'GL'
           AND t.S4Future11 <> 'N'
           AND t.TranDate >= @cashdate
           and t.LedgerID = @GLSetupLedgerID


  	OPEN RGLTranCursor
  	FETCH NEXT FROM RGLTranCursor INTO @CpnyID, @BankAcct, @BankSub, @TranDate, @ClearDate, @DrAmt, @CrAmt, @CuryDrAmt, @CuryCrAmt, @Status

  	WHILE (@@FETCH_STATUS <> -1)
  	BEGIN
 	    IF (@@FETCH_STATUS <> -2) AND (SELECT MAX(ReconDate) FROM BankRec WHERE CpnyID = @CpnyID AND BankAcct = @BankAcct AND BankSub = @BankSub AND ReconcileFlag <> 0) >= @TranDate
      	BEGIN
			IF @DrAmt <> 0
				SELECT @DrCr = 'D', @TranAmt = @DrAmt, @CuryTranAmt = @CuryDrAmt
			ELSE
				SELECT @DrCr = 'C', @TranAmt = @CrAmt, @CuryTranAmt = @CuryCrAmt

			EXEC Update_Existing_BankRecs 'GL', @CpnyID, @BankAcct, @BankSub, @TranDate, @ClearDate, '', @DrCr, @CuryTranAmt, @TranAmt, @Status

            		IF @@ERROR < > 0 GOTO ABORT

		END
		FETCH NEXT FROM RGLTranCursor INTO @CpnyID, @BankAcct, @BankSub, @TranDate, @ClearDate, @DrAmt, @CrAmt, @CuryDrAmt, @CuryCrAmt, @Status
  	END
  	CLOSE RGLTranCursor
  	DEALLOCATE RGLTranCursor


	IF @CuryDecPl IS NULL SELECT @CuryDecPl = @BaseDecPl

	INSERT	#TempAvgD
	SELECT	t.CpnyID, t.Acct, t.Sub,
		t.PerPost,
		'','',
		ROUND(SUM(CuryDrAmt - CuryCrAmt), @CuryDecPl), ROUND(SUM(DrAmt - CrAmt), @BaseDecPl),
		ROUND(SUM(CASE t.S4Future11 WHEN 'C' THEN CuryCrAmt ELSE 0 END), @CuryDecPl),
		ROUND(SUM(CASE t.S4Future11 WHEN 'C' THEN CrAmt ELSE 0 END), @BaseDecPl),
		ROUND(SUM(CASE t.S4Future11 WHEN 'C' THEN CuryDrAmt ELSE 0 END), @CuryDecPl),
		ROUND(SUM(CASE t.S4Future11 WHEN 'C' THEN DrAmt ELSE 0 END), @BaseDecPl),
		ROUND(SUM(CASE WHEN t.S4Future11 = 'C' AND CuryDrAmt = 0 THEN 1 ELSE 0 END), 0),
		ROUND(SUM(CASE WHEN t.S4Future11 = 'C' AND CuryDrAmt <> 0 THEN 1 ELSE 0 END), 0),
		ROUND(SUM(CASE WHEN t.S4Future11 = 'C' AND CuryDrAmt = 0 THEN DATEDIFF(day, t.TranDate, t.S4Future07) ELSE 0 END), 0),
		ROUND(SUM(CASE WHEN t.S4Future11 = 'C' AND CuryDrAmt <> 0 THEN DATEDIFF(day, t.TranDate, t.S4Future07) ELSE 0 END), 0)
	FROM	WrkRelease w INNER JOIN GLTran t ON w.BatNbr = t.BatNbr AND w.Module = t.Module
	WHERE	w.UserAddress = @UserAddress
           AND w.Module = 'GL'
           AND t.S4Future11 <> 'N'
           AND t.TranDate >= @cashdate
           and t.LedgerID = @GLSetupLedgerID
	GROUP	BY t.CpnyID, t.Acct, t.Sub, t.PerPost
	IF @@ERROR <> 0 GOTO Abort

	UPDATE	#TempAvgD SET MinPer = s.MinPer, MaxPer = s.MaxPer
	FROM	(SELECT t.Acct, t.Sub, t.CpnyID, t.InsPer,
			MinPer = CASE WHEN MAX(COALESCE(db.CpnyID, '')) = '' THEN t.InsPer ELSE
			CONVERT(CHAR(6), (CONVERT(INT, MAX(db.PerNbr)) / 100) * 100 +
			(((CONVERT(INT, MAX(db.PerNbr)) % 100) % (MAX(@NbrPer) + 1) + 1) / (MAX(@NbrPer) + 1)) * 101 +
			((CONVERT(INT, MAX(db.PerNbr)) % 100) % (MAX(@NbrPer) + 1) + 1) % (MAX(@NbrPer) + 1)) END,
			MaxPer = CASE WHEN MAX(COALESCE(dt.CpnyID, '')) = '' THEN CASE WHEN t.InsPer > MAX(c.PerNbr) THEN t.InsPer ELSE MAX(c.PerNbr) END ELSE
			CONVERT(CHAR(6), (CONVERT(INT, MIN(dt.PerNbr)) / 100) * 100 -
			((@NbrPer - (CONVERT(INT, MIN(dt.PerNbr)) % 100) % (@NbrPer + 1) + 1) / @NbrPer) * (100 - @NbrPer) +
			((CONVERT(INT, MIN(dt.PerNbr)) % 100) % (@NbrPer + 1) - 1) % @NbrPer) END
		FROM	CASetup c (NOLOCK) CROSS JOIN #TempAvgD t
			LEFT JOIN CashAvgD db ON db.CpnyID = t.CpnyID AND db.BankAcct = t.Acct AND db.BankSub = t.Sub AND db.PerNbr <= t.InsPer
			LEFT JOIN CashAvgD dt ON dt.CpnyID = t.CpnyID AND dt.BankAcct = t.Acct AND dt.BankSub = t.Sub AND dt.PerNbr >= t.InsPer
		GROUP	BY t.CpnyID, t.Acct, t.Sub, t.InsPer) s
	WHERE	#TempAvgD.Acct = s.Acct AND #TempAvgD.Sub = s.Sub AND #TempAvgD.CpnyID = s.CpnyID AND #TempAvgD.InsPer = s.InsPer
	IF @@ERROR <> 0 GOTO Abort

	SELECT	@MinPer = MIN(t.MinPer), @MaxPer = MAX(t.MaxPer),
		@PrvPer = CONVERT(CHAR(6), (CONVERT(INT, MIN(t.MinPer)) / 100) * 100 -
			((@NbrPer - (CONVERT(INT, MIN(t.MinPer)) % 100) % (@NbrPer + 1) + 1) / @NbrPer) * (100 - @NbrPer) +
			((CONVERT(INT, MIN(t.MinPer)) % 100) % (@NbrPer + 1) - 1) % @NbrPer)
	FROM #TempAvgD t
	IF @@ERROR <> 0 GOTO Abort

	WHILE	@MinPer <= @MaxPer BEGIN

		INSERT	CashAvgD (BankAcct, BankSub, CloseBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
                      	CuryCloseBal, curytotchkamt, curytotdepamt, LUpd_DateTime, LUpd_Prog, LUpd_User,
                      	NbrChecks, NbrChkDays, NbrDepDays, NbrDeposits, NoteID, PerNbr,
                      	S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                      	S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                      	TotChkAmt, TotDepAmt,
                      	User1, User2, User3, User4, User5, User6, User7, User8)
		SELECT	t.Acct, t.Sub, MAX(COALESCE(dp.CloseBal, 0)), t.CpnyID, GETDATE(), @ProgID, @Sol_User,
			MAX(COALESCE(dp.CuryCloseBal, 0)), 0, 0, GETDATE(), @ProgID, @Sol_User,
			0, 0, 0, 0, 0, @MinPer,
             		'', '', 0, 0, 0, 0,
             		'', '', 0, 0, '', '',
             		0, 0,
             		'', '', 0, 0, '', '', '', ''
		FROM	#TempAvgD t
			LEFT JOIN CashAvgD dp ON dp.BankAcct = t.Acct AND dp.BankSub = t.Sub AND dp.CpnyID = t.CpnyID AND dp.PerNbr = @PrvPer
			LEFT JOIN CashAvgD dc ON dc.BankAcct = t.Acct AND dc.BankSub = t.Sub AND dc.CpnyID = t.CpnyID AND dc.PerNbr = @MinPer
		WHERE	@MinPer BETWEEN t.MinPer AND t.MaxPer AND dc.CpnyID IS NULL
		GROUP	BY t.Acct, t.Sub, t.CpnyID
		IF @@ERROR <> 0 GOTO Abort

		SELECT	@PrvPer = @MinPer
		SELECT	@MinPer = CONVERT(CHAR(6), (CONVERT(INT, @MinPer) / 100) * 100 +
				(((CONVERT(INT, @MinPer) % 100) % (@NbrPer + 1) + 1)/(@NbrPer + 1)) * 101 +
				((CONVERT(INT, @MinPer) % 100) % (@NbrPer + 1) + 1) % (@NbrPer + 1))
		IF @@ERROR <> 0 GOTO Abort

	END

	SELECT	@MinPer = MIN(t.InsPer), @MaxPer = MAX(t.InsPer)
	FROM #TempAvgD t
	IF @@ERROR <> 0 GOTO Abort

	WHILE	@MinPer <= @MaxPer BEGIN

		UPDATE	CashAvgD SET CuryCloseBal = ROUND(CashAvgD.CuryCloseBal + t.CuryAmt, @CuryDecPl),
			     CloseBal = ROUND(CashAvgD.CloseBal + t.Amt, @BaseDecPl),
			     CuryTotChkAmt = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.CuryTotChkAmt + t.CuryChk, @CuryDecPl) ELSE CashAvgD.CuryTotChkAmt END,
			     TotChkAmt = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.TotChkAmt + t.Chk, @BaseDecPl) ELSE CashAvgD.TotChkAmt END,
			     CuryTotDepAmt = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.CuryTotDepAmt + t.CuryDep, @CuryDecPl) ELSE CashAvgD.CuryTotDepAmt END,
			     TotDepAmt = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.TotDepAmt + t.Dep, @BaseDecPl) ELSE CashAvgD.TotDepAmt END,
			     NbrChecks = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.NbrChecks + t.NbrChk, 0) ELSE CashAvgD.NbrChecks END,
			     NbrDeposits = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.NbrDeposits + t.NbrDep, 0) ELSE CashAvgD.NbrDeposits END,
			     NbrChkDays = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.NbrChkDays + t.ChkDays, 0) ELSE CashAvgD.NbrChkDays END,
			     NbrDepDays = CASE CashAvgD.PerNbr WHEN t.InsPer THEN
			     ROUND(CashAvgD.NbrDepDays + t.DepDays, 0) ELSE CashAvgD.NbrDepDays END,
			     LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User
		FROM	#TempAvgD t
		WHERE	CashAvgD.BankAcct = t.Acct AND CashAvgD.BankSub = t.Sub AND CashAvgD.CpnyID = t.CpnyID AND CashAvgD.PerNbr >= t.InsPer
			AND t.InsPer = @MinPer
		IF @@ERROR <> 0 GOTO Abort
			SELECT	@MinPer = CONVERT(CHAR(6), (CONVERT(INT, @MinPer) / 100) * 100 +
				(((CONVERT(INT, @MinPer) % 100) % (@NbrPer + 1) + 1)/(@NbrPer + 1)) * 101 +
				((CONVERT(INT, @MinPer) % 100) % (@NbrPer + 1) + 1) % (@NbrPer + 1))
		IF @@ERROR <> 0 GOTO Abort

	END

END

ELSE
BEGIN

Update g
Set g.S4future11 = 'N', g.S4Future03 = 0, g.S4Future07 = ''
From  WrkRelease w
	INNER JOIN GLTran g ON w.BatNbr = g.BatNbr and w.module = g.module

WHERE
	w.Module = 'GL'
	and w.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

END

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_01400CashSum] TO [MSDSL]
    AS [dbo];

