CREATE PROCEDURE WS_APSetup_INSERT
     @A1099byCpnyID smallint, @AllowBkupWthld smallint, @APAcct char(10), @APSub char(24), @AutoBatRpt smallint, @AutoRef smallint, @BkupWthldAcct char(10),
     @BkupWthldPct float, @BkupWthldSub char(24), @ChkAcct char(10), @ChkSub char(24), @ClassID char(10), @Crtd_DateTime smalldatetime, @Crtd_Prog char(8),
     @Crtd_User char(10), @Curr1099Yr char(4), @CurrPerNbr char(6), @CY1099Stat char(1), @DecPlPrcCst smallint, @DecPlQty smallint, @DfltPPVAccount char(10),
     @DfltPPVSub char(24), @DirectDeposit char(1), @DisableBkupWthldMsg smallint, @DiscTknAcct char(10), @DiscTknSub char(24), @DupInvcChk smallint, @ExcludeFreight char(1),
     @ExpAcct char(10), @ExpSub char(24), @GLPostOpt char(1), @Init smallint, @LastBatNbr char(10), @LastECheckNum char(10), @LastRefNbr char(10),
     @LUpd_DateTime smalldatetime, @LUpd_Prog char(8), @LUpd_User char(10), @MCuryBatRpt smallint, @Next1099Yr char(4), @NoteID int, @NY1099Stat char(1),
     @PastDue00 smallint, @PastDue01 smallint, @PastDue02 smallint, @PerDupChk smallint, @PerNbr char(6), @PerRetHist smallint, @PerRetTran smallint,
     @PMAvail smallint, @PPayAcct char(10), @PPaySub char(24), @PPVAcct char(10), @PPVSub char(24), @Req_PO_for_PP smallint, @RetChkRcncl smallint,
     @S4Future01 char(30), @S4Future02 char(30), @S4Future03 float, @S4Future04 float, @S4Future05 float, @S4Future06 float, @S4Future07 smalldatetime,
     @S4Future08 smalldatetime, @S4Future09 int, @S4Future10 int, @S4Future11 char(10), @S4Future12 char(10), @SetupId char(2), @SlsTax smallint,
     @SlsTaxDflt char(1), @Terms char(2), @TranDescDflt char(1), @UntlDue00 smallint, @UntlDue01 smallint, @UntlDue02 smallint, @UnvoucheredPOAlrt smallint,
     @User1 char(30), @User2 char(30), @User3 float, @User4 float, @User5 char(10), @User6 char(10), @User7 smalldatetime,
     @User8 smalldatetime, @Vend1099Lmt float, @VendViewDflt char(1)
 AS
     BEGIN
      INSERT INTO [APSetup]
       ([A1099byCpnyID], [AllowBkupWthld], [APAcct], [APSub], [AutoBatRpt], [AutoRef], [BkupWthldAcct],
        [BkupWthldPct], [BkupWthldSub], [ChkAcct], [ChkSub], [ClassID], [Crtd_DateTime], [Crtd_Prog],
        [Crtd_User], [Curr1099Yr], [CurrPerNbr], [CY1099Stat], [DecPlPrcCst], [DecPlQty], [DfltPPVAccount],
        [DfltPPVSub], [DirectDeposit], [DisableBkupWthldMsg], [DiscTknAcct], [DiscTknSub], [DupInvcChk], [ExcludeFreight],
        [ExpAcct], [ExpSub], [GLPostOpt], [Init], [LastBatNbr], [LastECheckNum], [LastRefNbr],
        [LUpd_DateTime], [LUpd_Prog], [LUpd_User], [MCuryBatRpt], [Next1099Yr], [NoteID], [NY1099Stat],
        [PastDue00], [PastDue01], [PastDue02], [PerDupChk], [PerNbr], [PerRetHist], [PerRetTran],
        [PMAvail], [PPayAcct], [PPaySub], [PPVAcct], [PPVSub], [Req_PO_for_PP], [RetChkRcncl],
        [S4Future01], [S4Future02], [S4Future03], [S4Future04], [S4Future05], [S4Future06], [S4Future07],
        [S4Future08], [S4Future09], [S4Future10], [S4Future11], [S4Future12], [SetupId], [SlsTax],
        [SlsTaxDflt], [Terms], [TranDescDflt], [UntlDue00], [UntlDue01], [UntlDue02], [UnvoucheredPOAlrt],
        [User1], [User2], [User3], [User4], [User5], [User6], [User7],
        [User8], [Vend1099Lmt], [VendViewDflt])
 VALUES
        (@A1099byCpnyID, @AllowBkupWthld, @APAcct, @APSub, @AutoBatRpt, @AutoRef, @BkupWthldAcct,
        @BkupWthldPct, @BkupWthldSub, @ChkAcct, @ChkSub, @ClassID, @Crtd_DateTime, @Crtd_Prog,
        @Crtd_User, @Curr1099Yr, @CurrPerNbr, @CY1099Stat, @DecPlPrcCst, @DecPlQty, @DfltPPVAccount,
        @DfltPPVSub, @DirectDeposit, @DisableBkupWthldMsg, @DiscTknAcct, @DiscTknSub, @DupInvcChk, @ExcludeFreight,
        @ExpAcct, @ExpSub, @GLPostOpt, @Init, @LastBatNbr, @LastECheckNum, @LastRefNbr,
        @LUpd_DateTime, @LUpd_Prog, @LUpd_User, @MCuryBatRpt, @Next1099Yr, @NoteID, @NY1099Stat, @PastDue00,
        @PastDue01, @PastDue02, @PerDupChk, @PerNbr, @PerRetHist, @PerRetTran,
        @PMAvail, @PPayAcct, @PPaySub, @PPVAcct, @PPVSub, @Req_PO_for_PP, @RetChkRcncl,
        @S4Future01, @S4Future02, @S4Future03, @S4Future04, @S4Future05, @S4Future06, @S4Future07,
        @S4Future08, @S4Future09, @S4Future10, @S4Future11, @S4Future12, @SetupId, @SlsTax,
        @SlsTaxDflt, @Terms, @TranDescDflt, @UntlDue00, @UntlDue01, @UntlDue02, @UnvoucheredPOAlrt,
        @User1, @User2, @User3, @User4, @User5, @User6, @User7,
        @User8, @Vend1099Lmt, @VendViewDflt);
     END

