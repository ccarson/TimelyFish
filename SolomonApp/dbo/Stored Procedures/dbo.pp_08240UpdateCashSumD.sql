 create procedure pp_08240UpdateCashSumD
@acct char(10),
@sub char(24),
@CpnyID char(10),
@pernbr char(6),
@trandate smalldatetime,
@amt float,
@curyamt float,
@Sol_User VARCHAR(10)

as
DECLARE @BaseCuryid CHAR (4)
SELECT @BaseCuryId = BaseCuryid FROM GLSetup (nolock)
/* Update the record if it exists, else insert it */
IF EXISTS (SELECT 'CashSumD record is present'
                 FROM CashSumD CSD
  	        WHERE CSD.BankAcct = @Acct
                  AND CSD.BankSub = @Sub
                  AND CSD.PerNbr = @PerNbr
                  AND CSD.TranDate = @Trandate
                  AND CSD.CpnyId = @CpnyId)
BEGIN
UPDATE cashsumd
   SET CuryReceipts = CuryReceipts + @curyamt,
        Receipts = Receipts + @amt,
        Lupd_DateTime = GetDate(),
        Lupd_Prog = '08240',
        Lupd_User = @Sol_User
 WHERE CpnyID = @CpnyID and
       BankAcct = @acct and
       BankSub = @sub and
       PerNbr = @pernbr and
       TranDate = @trandate
END
ELSE
BEGIN
   INSERT CashSumD (BankAcct, BankSub, ConCuryDisbursements, ConCuryReceipts,
	  ConDisbursements, ConReceipts, CuryDisbursements, CuryID, CuryReceipts,
	  Disbursements, NoteID, PerNbr, Receipts, TrANDate, User1, User2, User3, User4,
          CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User,
          LUpd_dateTime, LUpd_prog, LUpd_User,
          S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
          S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
          User5, User6, User7, User8)
   VALUES (@Acct, @Sub, 0, 0,
           0, 0, 0, @BaseCuryid , @CuryAmt,
           0, 0, @PerNbr, @Amt, @TranDate, '', '', 0, 0,
           @CpnyId, GETDATE(), '08240', @Sol_User,
           GETDATE(), '08240', @Sol_User,
           '', '', 0, 0, 0, 0,
           '', '', 0, 0, '', '',
           '', '', '', '')
END


