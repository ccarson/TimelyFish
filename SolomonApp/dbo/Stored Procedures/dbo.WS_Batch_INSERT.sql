CREATE PROCEDURE WS_Batch_INSERT
     @Acct char(10), @AutoRev smallint, @AutoRevCopy smallint, @BalanceType char(1), @BankAcct char(10), @BankSub char(24), @BaseCuryID char(4),
     @BatNbr char(10), @BatType char(1), @clearamt float, @Cleared smallint, @CpnyID char(10), @Crtd_DateTime smalldatetime, @Crtd_Prog char(8),
     @Crtd_User char(10), @CrTot float, @CtrlTot float, @CuryCrTot float, @CuryCtrlTot float, @CuryDepositAmt float, @CuryDrTot float,
     @CuryEffDate smalldatetime, @CuryId char(4), @CuryMultDiv char(1), @CuryRate float, @CuryRateType char(6), @Cycle smallint, @DateClr smalldatetime,
     @DateEnt smalldatetime, @DepositAmt float, @Descr char(30), @DrTot float, @EditScrnNbr char(5), @GLPostOpt char(1), @JrnlType char(3),
     @LedgerID char(10), @LUpd_DateTime smalldatetime, @LUpd_Prog char(8), @LUpd_User char(10), @Module char(2), @NbrCycle smallint, @NoteID int,
     @OrigBatNbr char(10), @OrigCpnyID char(10), @OrigScrnNbr char(5), @PerEnt char(6), @PerPost char(6), @Rlsed smallint, @S4Future01 char(30),
     @S4Future02 char(30), @S4Future03 float, @S4Future04 float, @S4Future05 float, @S4Future06 float, @S4Future07 smalldatetime, @S4Future08 smalldatetime,
     @S4Future09 int, @S4Future10 int, @S4Future11 char(10), @S4Future12 char(10), @Status char(1), @Sub char(24), @User1 char(30),
     @User2 char(30), @User3 float, @User4 float, @User5 char(10), @User6 char(10), @User7 smalldatetime, @User8 smalldatetime, @VOBatNbrForPP char(10)
 AS
     BEGIN
      INSERT INTO [Batch]
       ([Acct], [AutoRev], [AutoRevCopy], [BalanceType], [BankAcct], [BankSub], [BaseCuryID],
        [BatNbr], [BatType], [clearamt], [Cleared], [CpnyID], [Crtd_DateTime], [Crtd_Prog],
        [Crtd_User], [CrTot], [CtrlTot], [CuryCrTot], [CuryCtrlTot], [CuryDepositAmt], [CuryDrTot],
        [CuryEffDate], [CuryId], [CuryMultDiv], [CuryRate], [CuryRateType], [Cycle], [DateClr],
        [DateEnt], [DepositAmt], [Descr], [DrTot], [EditScrnNbr], [GLPostOpt], [JrnlType],
        [LedgerID], [LUpd_DateTime], [LUpd_Prog], [LUpd_User], [Module], [NbrCycle], [NoteID],
        [OrigBatNbr], [OrigCpnyID], [OrigScrnNbr], [PerEnt], [PerPost], [Rlsed], [S4Future01],
        [S4Future02], [S4Future03], [S4Future04], [S4Future05], [S4Future06], [S4Future07], [S4Future08],
        [S4Future09], [S4Future10], [S4Future11], [S4Future12], [Status], [Sub], [User1],
        [User2], [User3], [User4], [User5], [User6], [User7], [User8], [VOBatNbrForPP])
      VALUES
       (@Acct, @AutoRev, @AutoRevCopy, @BalanceType, @BankAcct, @BankSub, @BaseCuryID,
        @BatNbr, @BatType, @clearamt, @Cleared, @CpnyID, @Crtd_DateTime, @Crtd_Prog,
        @Crtd_User, @CrTot, @CtrlTot, @CuryCrTot, @CuryCtrlTot, @CuryDepositAmt, @CuryDrTot,
        @CuryEffDate, @CuryId, @CuryMultDiv, @CuryRate, @CuryRateType, @Cycle, @DateClr,
        @DateEnt, @DepositAmt, @Descr, @DrTot, @EditScrnNbr, @GLPostOpt, @JrnlType,
        @LedgerID, @LUpd_DateTime, @LUpd_Prog, @LUpd_User, @Module, @NbrCycle, @NoteID,
        @OrigBatNbr, @OrigCpnyID, @OrigScrnNbr, @PerEnt, @PerPost, @Rlsed, @S4Future01,
        @S4Future02, @S4Future03, @S4Future04, @S4Future05, @S4Future06, @S4Future07, @S4Future08,
        @S4Future09, @S4Future10, @S4Future11, @S4Future12, @Status, @Sub, @User1,
        @User2, @User3, @User4, @User5, @User6, @User7, @User8, @VOBatNbrForPP);
     END

