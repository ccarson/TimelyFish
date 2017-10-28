CREATE PROCEDURE WS_SlsTaxHist_INSERT
     @CpnyID char(10), @Crtd_DateTime smalldatetime, @Crtd_Prog char(8), @Crtd_User char(10), @LUpd_DateTime smalldatetime, @LUpd_Prog char(8), @LUpd_User char(10),
     @NoteId int, @S4Future01 char(30), @S4Future02 char(30), @S4Future03 float, @S4Future04 float, @S4Future05 float, @S4Future06 float,
     @S4Future07 smalldatetime, @S4Future08 smalldatetime, @S4Future09 int, @S4Future10 int, @S4Future11 char(10), @S4Future12 char(10), @TaxId char(10),
     @TotTaxColl float, @TotTaxPaid float, @TxblPurchTot float, @txblslstot float, @User1 char(30), @User2 char(30), @User3 float,
     @User4 float, @User5 char(10), @User6 char(10), @User7 smalldatetime, @User8 smalldatetime, @YrMon char(6)
 AS
     BEGIN
      INSERT INTO [SlsTaxHist]
       ([CpnyID], [Crtd_DateTime], [Crtd_Prog], [Crtd_User], [LUpd_DateTime], [LUpd_Prog], [LUpd_User],
        [NoteId], [S4Future01], [S4Future02], [S4Future03], [S4Future04], [S4Future05], [S4Future06],
        [S4Future07], [S4Future08], [S4Future09], [S4Future10], [S4Future11], [S4Future12], [TaxId],
        [TotTaxColl], [TotTaxPaid], [TxblPurchTot], [txblslstot], [User1], [User2], [User3],
        [User4], [User5], [User6], [User7], [User8], [YrMon])
      VALUES
       (@CpnyID, @Crtd_DateTime, @Crtd_Prog, @Crtd_User, @LUpd_DateTime, @LUpd_Prog, @LUpd_User,
        @NoteId, @S4Future01, @S4Future02, @S4Future03, @S4Future04, @S4Future05, @S4Future06,
        @S4Future07, @S4Future08, @S4Future09, @S4Future10, @S4Future11, @S4Future12, @TaxId,
        @TotTaxColl, @TotTaxPaid, @TxblPurchTot, @txblslstot, @User1, @User2, @User3,
        @User4, @User5, @User6, @User7, @User8, @YrMon);
     END

