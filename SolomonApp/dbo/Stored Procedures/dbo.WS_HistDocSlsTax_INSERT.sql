CREATE PROCEDURE WS_HistDocSlsTax_INSERT
     @BOCntr SMALLINT,@CpnyID CHAR(10),@Crtd_DateTime SMALLDATETIME,@Crtd_Prog CHAR(8),@Crtd_User CHAR(10),
     @CuryDocTot FLOAT,@CuryID CHAR(4),@CuryMultDiv CHAR(1),@CuryRate FLOAT,@CuryTaxTot FLOAT,
     @CuryTxblTot FLOAT,@CustVendId CHAR(15),@DocTot FLOAT,@DocType CHAR(2),@JrnlType CHAR(2),
     @LUpd_DateTime SMALLDATETIME,@LUpd_Prog CHAR(8),@LUpd_User CHAR(10),@RefNbr CHAR(10),@Reported SMALLINT,
     @RptBegDate SMALLDATETIME,@RptEndDate SMALLDATETIME,@S4Future01 CHAR(30),@S4Future02 CHAR(30),
     @S4Future03 FLOAT,@S4Future04 FLOAT,@S4Future05 FLOAT,@S4Future06 FLOAT,@S4Future07 SMALLDATETIME,
     @S4Future08 SMALLDATETIME,@S4Future09 INT,@S4Future10 INT,@S4Future11 CHAR(10),@S4Future12 CHAR(10),
     @TaxId CHAR(10),@TaxTot FLOAT,@TxblTot FLOAT,@User1 CHAR(30),@User2 CHAR(30),@User3 FLOAT,@User4 FLOAT,
     @User5 CHAR(10),@User6 CHAR(10),@User7 SMALLDATETIME,@User8 SMALLDATETIME,@YrMon CHAR(6)
AS
  BEGIN
      INSERT INTO [HistDocSlsTax]
                 ([BOCntr],[CpnyID],[Crtd_DateTime],[Crtd_Prog],[Crtd_User],[CuryDocTot],[CuryID],
                  [CuryMultDiv],[CuryRate],[CuryTaxTot],[CuryTxblTot],[CustVendId],[DocTot],
                  [DocType],[JrnlType],[LUpd_DateTime],[LUpd_Prog],[LUpd_User],[RefNbr],[Reported],
                  [RptBegDate],[RptEndDate],[S4Future01],[S4Future02],[S4Future03],[S4Future04],
                  [S4Future05],[S4Future06],[S4Future07],[S4Future08],[S4Future09],[S4Future10],
                  [S4Future11],[S4Future12],[TaxId],[TaxTot],[TxblTot],[User1],[User2],[User3],[User4],
                  [User5],[User6],[User7],[User8],[YrMon])
      VALUES (@BOCntr,@CpnyID,@Crtd_DateTime,@Crtd_Prog,@Crtd_User,@CuryDocTot,@CuryID,
              @CuryMultDiv,@CuryRate,@CuryTaxTot,@CuryTxblTot,@CustVendId,@DocTot,
              @DocType,@JrnlType,@LUpd_DateTime,@LUpd_Prog,@LUpd_User,@RefNbr,@Reported,
              @RptBegDate,@RptEndDate,@S4Future01,@S4Future02,@S4Future03,@S4Future04,
              @S4Future05,@S4Future06,@S4Future07,@S4Future08,@S4Future09,@S4Future10,
              @S4Future11,@S4Future12,@TaxId,@TaxTot,@TxblTot,@User1,@User2,@User3,@User4,
              @User5,@User6,@User7,@User8,@YrMon);
  END 

