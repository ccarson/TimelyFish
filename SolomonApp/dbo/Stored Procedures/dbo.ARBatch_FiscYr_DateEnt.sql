 /****** Object:  Stored Procedure dbo.ARBatch_FiscYr_DateEnt    Script Date: 8/9/00 12:49:19 PM ******/
CREATE  PROCEDURE ARBatch_FiscYr_DateEnt
        @CpnyID         VARCHAR(10),
        @Acct           VARCHAR(10),
        @Sub            VARCHAR(24),
        @StartDate      SMALLDATETIME,
        @EndDate        SMALLDATETIME,
        @FiscYr         VARCHAR(4)
AS
SELECT Acct=MAX(b.Acct),
       AutoRev=MAX(b.AutoRev),
       AutoRev=MAX(b.AutoRevCopy),
       AutoRev=MAX(b.BalanceType),
       BankAcct = MAX(b.bankacct),
       BankSub = MAX(b.banksub),
       BaseCuryID=MAX(b.BaseCuryID),
       BatNbr=MAX(b.BatNbr),
       BatType=MAX(b.BatType),
       clearamt=MAX(b.clearamt),
       Cleared=MAX(b.Cleared),
       CpnyID=MAX(b.CpnyID),
       Crtd_DateTime=MAX(b.Crtd_DateTime),
       Crtd_Prog=MAX(b.Crtd_Prog),
       Crtd_User=MAX(b.Crtd_User),
       CrTot=MAX(b.CrTot),
       CtrlTot=MAX(b.CtrlTot),
       CuryCrTot=MAX(b.CuryCrTot),
       CuryCtrlTot=MAX(b.CuryCtrlTot),
       CuryDepositAmt = MAX(b.CuryDepositAmt),
       CuryDrTot=MAX(CuryDrTot),
       CuryEffDate=MAX(b.CuryEffDate),
       CuryId=MAX(b.CuryId),
       CuryMultDiv=MAX(b.CuryMultDiv),
       CuryRate=MAX(b.CuryRate),
       CuryRateType=MAX(b.CuryRateType),
       Cycle=MAX(b.Cycle),
       DateClr=MAX(b.DateClr),
       DateEnt=MAX(b.DateEnt),
       DepositAmt = MAX(b.DepositAmt),
       Descr=MAX(b.Descr),
       DrTot=MAX(b.DrTot),
       EditScrnNbr=MAX(b.EditScrnNbr),
       GLPostOpt=MAX(b.GLPostOpt),
       JrnlType=MAX(b.JrnlType),
       LedgerID=MAX(b.LedgerID),
       LUpd_DateTime=MAX(b.LUpd_DateTime),
       LUpd_Prog=MAX(b.LUpd_Prog),
       LUpd_User=MAX(b.LUpd_User),
       Module=MAX(b.Module),
       NbrCycle=MAX(b.NbrCycle),
       NoteID=MAX(b.NoteID),
       OrigBatNbr=MAX(b.OrigBatNbr),
       OrigCpnyID=MAX(b.OrigCpnyID),
       OrigScrnNbr=MAX(b.OrigScrnNbr),
       PerEnt=MAX(b.PerEnt),
       PerPost=MAX(b.PerPost),
       Rlsed=MAX(b.Rlsed),
       S4Future01=MAX(b.S4Future01),S4Future02=MAX(b.S4Future02),S4Future03=MAX(b.S4Future03),S4Future04=MAX(b.S4Future04),
       S4Future05=MAX(b.S4Future05),S4Future06=MAX(b.S4Future06),S4Future07=MAX(b.S4Future07),S4Future08=MAX(b.S4Future08),
       S4Future09=MAX(b.S4Future09),S4Future10=MAX(b.S4Future10),S4Future11=MAX(b.S4Future11),S4Future12=MAX(b.S4Future12),
       Status=MAX(b.Status),
       Sub=MAX(b.Sub),
       User1=MAX(b.User1),User2=MAX(b.User2),User3=MAX(b.User3),User4=MAX(b.User4),User5=MAX(b.User5),User6=MAX(b.User6),
       User7=MAX(b.User7),User8=MAX(b.User8),
       tstamp=MAX(b.tstamp)

FROM    Batch b INNER JOIN ARDoc n ON n.BatNbr=b.BatNbr

WHERE   b.Cpnyid = @CpnyId AND
        b.BankAcct = @Acct AND
        b.BankSub = @Sub AND
        b.dateent BETWEEN @StartDate AND @EndDate AND
        convert (char(4), b.perpost) >= @FiscYr AND
        b.rlsed = 1 AND
        b.module = 'AR' AND
        b.Status <> 'V' AND
        b.battype not in ('C', 'R') AND
        n.DocType IN ('PA', 'PP', 'CS', 'NS')


GROUP BY b.BatNbr, b.DateEnt

ORDER BY b.batnbr, b.dateent



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARBatch_FiscYr_DateEnt] TO [MSDSL]
    AS [dbo];

