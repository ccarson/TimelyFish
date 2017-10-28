 CREATE PROCEDURE pp_08400CashSum @UserAddress VARCHAR(21), @Sol_User VARCHAR(10),
                                      @ProgID VARCHAR(8),  @BaseDecPl INT, @CRResult INT OUTPUT

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
DECLARE @Debug INT
DECLARE @CpnyID VARCHAR ( 10)
DECLARE @BankAcct VARCHAR(10)
DECLARE @BankSub VARCHAR ( 24)
DECLARE @TranDate SMALLDATETIME
DECLARE @CuryAmt FLOAT (8)
DECLARE @BaseAmt FLOAT (8)

DECLARE @PerPost          CHAR (6)
DECLARE @CloseBal         FLOAT
DECLARE @CuryCloseBal     FLOAT
DECLARE @InsPer           INT
DECLARE @NbrPer           INT
DECLARE @CuryDecPl        SMALLINT
DECLARE @CAPerNbr         INT

SELECT @Debug = CASE WHEN @UserAddress = 'ARDebug' THEN 1
                     ELSE 0
                END
 IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2100-10:  Create CashSumD records'
  END

/*** IF Cash is installed and it is past the accept trans date, ***/
/*** Insert rows if they are missing then update cashsumd       ***/

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
    FROM vp_08400CashDetail t INNER JOIN CashAcct a
                                 ON t.cpnyid = a.cpnyid
                                AND t.Acct = a.BankAcct
                                AND t.Sub = a.BankSub
                              INNER JOIN CASetup c
                                 ON c.AcceptTransDate <= t.TranDate
                               LEFT OUTER JOIN CashSumD d
  	                         ON t.Acct = d.BankAcct
                                AND t.Sub = d.BankSub
                                AND t.PerPost = d.PerNbr
                                AND t.TrANDate = d.TrANDate
                                AND t.cpnyid = d.cpnyid
   WHERE d.BankAcct IS NULL
     AND useraddress=@useraddress

  IF @@ERROR < > 0 GOTO ABORT

  IF (@Debug = 1)
  BEGIN
    PRINT CONVERT(VARCHAR(30), GETDATE(), 113)
    PRINT 'Debug...Step 2100-20:  Update CashSumD with Amounts'
  END

  UPDATE d Set @CuryDecPl = c.DecPl, --Setting CuryDecPl here so we do not have to join to currency again.
	d.Receipts =
	ROUND(d.Receipts + v.Receipt,@BaseDecPl),  -- Voids are negative receipts not disbursements
        d.CuryReceipts =
        ROUND(d.CuryReceipts + v.CuryReceipt,c.decpl)
    FROM vp_08400CashDetail v INNER JOIN CashSumD d
                                 ON v.Acct = d.BankAcct
                                AND v.Sub = d.BankSub
                                AND v.PerPost = d.PerNbr
                                AND v.cpnyid = d.cpnyid
                                AND v.TranDate = d.TranDate
                              INNER JOIN CASetup s
                                 ON s.AcceptTransDate <= v.TranDate
                               INNER JOIN Currncy c
                                  ON d.curyid = c.curyid
   WHERE useraddress=@useraddress
   IF @@ERROR < > 0 GOTO ABORT

SET @BankAcct = ' '

SELECT @BankAcct = v.Acct, @BankSub = v.Sub, @CpnyID = v.CpnyID, @TranDate = v.TranDate,
       @CuryAmt = v.CuryReceipt, @BaseAmt = v.Receipt, @PerPost = v.PerPost
  FROM vp_08400CashDetail v INNER JOIN CASetup s
                               ON s.AcceptTransDate <= v.TranDate
 WHERE useraddress=@useraddress
IF @@ERROR < > 0 GOTO ABORT

IF @BankAcct < > ' '
BEGIN
  IF (SELECT MAX(ReconDate) FROM BankRec
       WHERE CpnyID = @CpnyID AND BankAcct = @BankAcct AND BankSub = @BankSub) >= @TranDate
  BEGIN
     EXEC Update_Existing_BankRecs 'AR', @CpnyID, @BankAcct, @BankSub, @TranDate, '', '', '', @CuryAmt, @BaseAmt, 'O'
     IF @@ERROR < > 0 GOTO ABORT
  END

  SELECT @InsPer = CONVERT(INT, PerNbr), @CloseBal = CloseBal, @CuryCloseBal = CuryCloseBal
  FROM   CashAvgD
  WHERE  BankAcct = @BankAcct AND BankSub = @BankSub AND CpnyID = @CpnyID AND PerNbr <= @PerPost
  ORDER BY PerNbr
  IF @@ERROR < > 0 GOTO ABORT

  SELECT @NbrPer = NbrPer FROM GLSetup (NOLOCK)
  SELECT @CAPerNbr = CONVERT(INT, PerNbr) FROM CASetup (NOLOCK)
  IF @NbrPer IS NULL OR @CAPerNbr IS NULL GOTO ABORT
  IF @CuryDecPl IS NULL SELECT @CuryDecPl = @BaseDecPl
  IF @InsPer IS NULL SELECT @InsPer = CONVERT(INT, @PerPost), @CloseBal = 0, @CuryCloseBal = 0
  ELSE SELECT @InsPer = (@InsPer / 100 + (@InsPer % 100 + 1)/(@NbrPer + 1)) * 100 +
                        (@InsPer % 100 + 1)%(@NbrPer + 1) + (@InsPer % 100 + 1)/(@NbrPer + 1)
  IF @@ERROR < > 0 GOTO ABORT

  WHILE @InsPer <= CONVERT(INT, @PerPost) OR
        @InsPer <= @CAPerNbr AND NOT EXISTS(
        SELECT * FROM CashAvgD
        WHERE BankAcct = @BankAcct AND BankSub = @BankSub AND CpnyID = @CpnyID AND PerNbr = CONVERT(CHAR(6), @InsPer)
        ) BEGIN
     INSERT CashAvgD (BankAcct, BankSub, CloseBal, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
                      CuryCloseBal, curytotchkamt, curytotdepamt, LUpd_DateTime, LUpd_Prog, LUpd_User,
                      NbrChecks, NbrChkDays, NbrDepDays, NbrDeposits, NoteID, PerNbr,
                      S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                      S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                      TotChkAmt, TotDepAmt,
                      User1, User2, User3, User4, User5, User6, User7, User8)
     VALUES (@BankAcct, @BankSub, @CloseBal, @CpnyID, GETDATE(), @ProgID, @Sol_User,
             @CuryCloseBal, 0, 0, GETDATE(), @ProgID, @Sol_User,
             0, 0, 0, 0, 0, CONVERT(CHAR(6), @InsPer),
             '', '', 0, 0, 0, 0,
             '', '', 0, 0, '', '',
             0, 0,
             '', '', 0, 0, '', '', '', '')
     IF @@ERROR < > 0 GOTO ABORT

     SELECT @InsPer = (@InsPer / 100 + (@InsPer % 100 + 1)/(@NbrPer + 1)) * 100 +
                      (@InsPer % 100 + 1)%(@NbrPer + 1) + (@InsPer % 100 + 1)/(@NbrPer + 1)
     IF @@ERROR < > 0 GOTO ABORT
     END

  UPDATE CashAvgD SET CloseBal = ROUND(CloseBal + @BaseAmt, @BaseDecPl),
                      CuryCloseBal = ROUND(CuryCloseBal + @CuryAmt, @CuryDecPl)
  WHERE  BankAcct = @BankAcct AND BankSub = @BankSub AND CpnyID = @CpnyID AND PerNbr >= @PerPost
  IF @@ERROR < > 0 GOTO ABORT

END

SELECT @CRResult = 1
GOTO FINISH

ABORT:
SELECT @CRResult = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_08400CashSum] TO [MSDSL]
    AS [dbo];

