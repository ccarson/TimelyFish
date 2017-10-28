CREATE PROCEDURE WS_GLTran_INSERT
      @Acct char(10), @AppliedDate smalldatetime, @BalanceType char(1), @BaseCuryID char(4), @BatNbr char(10), @CpnyID char(10), @CrAmt float,
      @Crtd_DateTime smalldatetime, @Crtd_Prog char(8), @Crtd_User char(10), @CuryCrAmt float, @CuryDrAmt float, @CuryEffDate smalldatetime, @CuryId char(4),
      @CuryMultDiv char(1), @CuryRate float, @CuryRateType char(6), @DrAmt float, @EmployeeID char(10), @ExtRefNbr char(15), @FiscYr char(4),
      @IC_Distribution smallint, @Id char(20), @JrnlType char(3), @Labor_Class_Cd char(4), @LedgerID char(10), @LineId int, @LineNbr smallint,
      @LineRef char(5), @LUpd_DateTime smalldatetime, @LUpd_Prog char(8), @LUpd_User char(10), @Module char(2), @NoteID int, @OrigAcct char(10),
      @OrigBatNbr char(10), @OrigCpnyID char(10), @OrigSub char(24), @PC_Flag char(1), @PC_ID char(20), @PC_Status char(1), @PerEnt char(6),
      @PerPost char(6), @Posted char(1), @ProjectID char(16), @Qty float, @RefNbr char(10), @RevEntryOption char(1), @Rlsed smallint,
      @S4Future01 char(30), @S4Future02 char(30), @S4Future03 float, @S4Future04 float, @S4Future05 float, @S4Future06 float, @S4Future07 smalldatetime,
      @S4Future08 smalldatetime, @S4Future09 int, @S4Future10 int, @S4Future11 char(10), @S4Future12 char(10), @ServiceDate smalldatetime, @Sub char(24),
      @TaskID char(32), @TranDate smalldatetime, @TranDesc char(30), @TranType char(2), @Units float, @User1 char(30), @User2 char(30),
      @User3 float, @User4 float, @User5 char(10), @User6 char(10), @User7 smalldatetime, @User8 smalldatetime
 AS
     BEGIN
      INSERT INTO [GLTran]
       ([Acct], [AppliedDate], [BalanceType], [BaseCuryID], [BatNbr], [CpnyID], [CrAmt],
        [Crtd_DateTime], [Crtd_Prog], [Crtd_User], [CuryCrAmt], [CuryDrAmt], [CuryEffDate], [CuryId],
        [CuryMultDiv], [CuryRate], [CuryRateType], [DrAmt], [EmployeeID], [ExtRefNbr], [FiscYr],
        [IC_Distribution], [Id], [JrnlType], [Labor_Class_Cd], [LedgerID], [LineId], [LineNbr],
        [LineRef], [LUpd_DateTime], [LUpd_Prog], [LUpd_User], [Module], [NoteID], [OrigAcct],
        [OrigBatNbr], [OrigCpnyID], [OrigSub], [PC_Flag], [PC_ID], [PC_Status], [PerEnt],
        [PerPost], [Posted], [ProjectID], [Qty], [RefNbr], [RevEntryOption], [Rlsed],
        [S4Future01], [S4Future02], [S4Future03], [S4Future04], [S4Future05], [S4Future06], [S4Future07],
        [S4Future08], [S4Future09], [S4Future10], [S4Future11], [S4Future12], [ServiceDate], [Sub],
        [TaskID], [TranDate], [TranDesc], [TranType], [Units], [User1], [User2],
        [User3], [User4], [User5], [User6], [User7], [User8])
      VALUES
       (@Acct, @AppliedDate, @BalanceType, @BaseCuryID, @BatNbr, @CpnyID, @CrAmt,
        @Crtd_DateTime, @Crtd_Prog, @Crtd_User, @CuryCrAmt, @CuryDrAmt, @CuryEffDate, @CuryId,
        @CuryMultDiv, @CuryRate, @CuryRateType, @DrAmt, @EmployeeID, @ExtRefNbr, @FiscYr,
        @IC_Distribution, @Id, @JrnlType, @Labor_Class_Cd, @LedgerID, @LineId, @LineNbr,
        @LineRef, @LUpd_DateTime, @LUpd_Prog, @LUpd_User, @Module, @NoteID, @OrigAcct,
        @OrigBatNbr, @OrigCpnyID, @OrigSub, @PC_Flag, @PC_ID, @PC_Status, @PerEnt,
        @PerPost, @Posted, @ProjectID, @Qty, @RefNbr, @RevEntryOption, @Rlsed,
        @S4Future01, @S4Future02, @S4Future03, @S4Future04, @S4Future05, @S4Future06, @S4Future07,
        @S4Future08, @S4Future09, @S4Future10, @S4Future11, @S4Future12, @ServiceDate, @Sub,
        @TaskID, @TranDate, @TranDesc, @TranType, @Units, @User1, @User2,
        @User3, @User4, @User5, @User6, @User7, @User8);
     END

