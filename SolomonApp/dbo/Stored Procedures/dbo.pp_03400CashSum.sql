 CREATE PROCEDURE pp_03400CashSum @UserAddress VARCHAR(21), @ProgId CHAR(8), @Sol_User CHAR(10), @Result INT OUTPUT AS

/***** File Name: 0381pp_03400CashSum.Sql				*****/
/***** Last Modified by Tawnya James on 7/09/99 at 4:13 pm *****/

---DECLARE @Progid CHAR (8)
---DECLARE @Sol_User CHAR (10)

---SELECT @ProgID =   '03400',
---       @Sol_User = 'SOLOMON'
DECLARE @CpnyID VARCHAR ( 10)
DECLARE @BankAcct VARCHAR(10)
DECLARE @BankSub VARCHAR ( 24)
DECLARE @TranDate SMALLDATETIME
DECLARE @CuryAmt FLOAT (8)
DECLARE @BaseAmt FLOAT (8)
DECLARE @DocType VARCHAR( 2)

DECLARE @basedecpl SMALLINT
DECLARE @cashdate SMALLDATETIME

CREATE	TABLE #TempAvgD (CpnyID CHAR(10), Acct CHAR(10), Sub CHAR(24),
			 InsPer CHAR(6), MinPer CHAR(6), MaxPer CHAR(6),
			 CuryAmt FLOAT, Amt FLOAT)
IF @@ERROR <> 0 GOTO Abort

DECLARE	@CuryDecPl	SMALLINT
DECLARE	@MinPer		CHAR(6)
DECLARE	@MaxPer		CHAR(6)
DECLARE	@PrvPer		CHAR(6)
DECLARE	@NbrPer		SMALLINT

SELECT @cashdate = accepttransdate FROM CASetup (NOLOCK)
select @basedecpl = coalesce(c.decpl, 0), @NbrPer = s.NbrPer from glsetup s  (nolock) left join currncy c (nolock) on s.basecuryid = c.curyid
IF @NbrPer IS NULL GOTO Abort

if @cashdate is not null
BEGIN

	/***** Create New Record in CashSumD if No Matching Record Exist *****/

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
	FROM    cashacct a,vp_03400CashDetail t LEFT OUTER JOIN CashSumD d
		ON t.Acct = d.BankAcct AND t.Sub = d.BankSub AND t.PerPost = d.PerNbr AND
		t.TrANDate = d.TrANDate and t.cpnyid = d.cpnyid

	WHERE d.BankAcct IS NULL
      		and t.cpnyid = a.cpnyid and t.Acct = a.BankAcct AND t.Sub = a.BankSub and
      		t.trandate >= @cashdate AND useraddress=@useraddress
	IF @@ERROR < > 0 GOTO ABORT

	/***** Update CashSumD with Amounts *****/

	UPDATE d Set @CuryDecPl = c.DecPl,
		d.CuryDisbursements = ROUND(d.CuryDisbursements + v.CuryDisbursement,c.decpl),
		d.Disbursements = ROUND(d.Disbursements + v.Disbursement,@basedecpl),
		d.Receipts = ROUND(d.Receipts + v.Receipt,@basedecpl),
        	d.CuryReceipts = ROUND(d.CuryReceipts + v.CuryReceipt,c.decpl),
		d.LUpd_dateTime = GETDATE(),
		d.LUpd_Prog = @ProgID,
		d.LUpd_User = @Sol_User
	FROM vp_03400CashDetail v, CashSumD d, Currncy c
	WHERE v.Acct = d.BankAcct AND v.Sub = d.BankSub AND v.PerPost = d.PerNbr AND
		v.TranDate = d.TranDate and v.cpnyid = d.cpnyid and d.curyid = c.curyid
		and v.trandate >= @cashdate
		and useraddress=@useraddress
	IF @@ERROR < > 0 GOTO ABORT

	DECLARE RDocCursor CURSOR FOR
	SELECT d.CpnyID, d.Acct, d.Sub, d.DocDate, d.OrigDocAmt, d.CuryOrigDocAmt, d.DocType
		FROM WrkRelease w, APDoc d
		WHERE w.UserAddress = @UserAddress
           		AND w.BatNbr = d.BatNbr
           		AND w.Module = 'AP'
           		AND d.DocType IN ('HC', 'EP', 'CK', 'VC')
			AND d.DocDate >= @cashdate

	OPEN RDocCursor
	FETCH NEXT FROM RDocCursor INTO @CpnyID, @BankAcct, @BankSub, @TranDate, @BaseAmt, @CuryAmt, @DocType

	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		IF (@@FETCH_STATUS <> -2) AND (SELECT MAX(ReconDate) FROM BankRec WHERE CpnyID = @CpnyID AND BankAcct = @BankAcct AND BankSub = @BankSub) >= @TranDate
		BEGIN

			EXEC Update_Existing_BankRecs 'AP', @CpnyID, @BankAcct, @BankSub, @TranDate, '', @DocType, '', @CuryAmt, @BaseAmt, 'O'
			IF @@ERROR < > 0 GOTO ABORT

  		END
		FETCH NEXT FROM RDocCursor INTO @CpnyID, @BankAcct, @BankSub, @TranDate, @BaseAmt, @CuryAmt, @DocType
	END
	CLOSE RDocCursor
	DEALLOCATE RDocCursor
 	IF @CuryDecPl IS NULL SELECT @CuryDecPl = @BaseDecPl

	INSERT	#TempAvgD
	SELECT	d.CpnyID, d.Acct, d.Sub,
		d.PerPost,
		'','',
		ROUND(SUM(CASE d.DocType WHEN 'VC' THEN -d.CuryOrigDocAmt ELSE d.CuryOrigDocAmt END), @CuryDecPl),
		ROUND(SUM(CASE d.DocType WHEN 'VC' THEN -d.OrigDocAmt ELSE d.OrigDocAmt END), @BaseDecPl)
	FROM	WrkRelease w INNER JOIN APDoc d ON w.BatNbr = d.BatNbr
	WHERE	w.UserAddress = @UserAddress
           AND w.Module = 'AP'
           AND d.DocType IN ('HC', 'CK', 'VC')
	   AND d.DocDate >= @cashdate
	GROUP	BY d.CpnyID, d.Acct, d.Sub, d.PerPost
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
		SELECT	t.Acct, t.Sub, COALESCE(dp.CloseBal, 0), t.CpnyID, GETDATE(), @ProgID, @Sol_User,
			COALESCE(dp.CuryCloseBal, 0), 0, 0, GETDATE(), @ProgID, @Sol_User,
			0, 0, 0, 0, 0, @MinPer,
             		'', '', 0, 0, 0, 0,
             		'', '', 0, 0, '', '',
             		0, 0,
             		'', '', 0, 0, '', '', '', ''
		FROM	#TempAvgD t
			LEFT JOIN CashAvgD dp ON dp.BankAcct = t.Acct AND dp.BankSub = t.Sub AND dp.CpnyID = t.CpnyID AND dp.PerNbr = @PrvPer
			LEFT JOIN CashAvgD dc ON dc.BankAcct = t.Acct AND dc.BankSub = t.Sub AND dc.CpnyID = t.CpnyID AND dc.PerNbr = @MinPer
		WHERE	@MinPer BETWEEN t.MinPer AND t.MaxPer AND dc.CpnyID IS NULL
		IF @@ERROR <> 0 GOTO Abort

		SELECT	@PrvPer = @MinPer
		SELECT	@MinPer = CONVERT(CHAR(6), (CONVERT(INT, @MinPer) / 100) * 100 +
				(((CONVERT(INT, @MinPer) % 100) % (@NbrPer + 1) + 1)/(@NbrPer + 1)) * 101 +
				((CONVERT(INT, @MinPer) % 100) % (@NbrPer + 1) + 1) % (@NbrPer + 1))
		IF @@ERROR <> 0 GOTO Abort

	END

	UPDATE	CashAvgD SET CuryCloseBal = ROUND(CashAvgD.CuryCloseBal - t.CuryAmt, @CuryDecPl),
			     CloseBal = ROUND(CashAvgD.CloseBal - t.Amt, @BaseDecPl)
	FROM	#TempAvgD t
	WHERE	CashAvgD.BankAcct = t.Acct AND CashAvgD.BankSub = t.Sub AND CashAvgD.CpnyID = t.CpnyID AND CashAvgD.PerNbr >= t.InsPer
	IF @@ERROR <> 0 GOTO Abort
	END

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:


