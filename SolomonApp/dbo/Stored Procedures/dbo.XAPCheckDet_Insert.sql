CREATE PROCEDURE XAPCheckDet_Insert @BatNbr char(10) AS
Delete from XAPCheckDet where BatNbr = @BatNbr

Insert into XAPCheckDet(BatNbr, CheckRefNbr, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryDiscAmt, CuryGrossAmt, CuryID, CuryMultDiv, CuryPmtAmt, CuryRate, DiscAmt, DocType, GrossAmt, LUpd_DateTime, LUpd_Prog, LUpd_User, PmtAmt, RefNbr, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, StubLine, User1, User2, User3, User4, User5, User6, User7, User8)
Select BatNbr, CheckRefNbr, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryDiscAmt, CuryGrossAmt, CuryID, CuryMultDiv, CuryPmtAmt, CuryRate, DiscAmt, DocType, GrossAmt, LUpd_DateTime, LUpd_Prog, LUpd_User, PmtAmt, RefNbr, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, StubLine, User1, User2, User3, User4, User5, User6, User7, User8 from APCheckDet where batnbr = @BatNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XAPCheckDet_Insert] TO [MSDSL]
    AS [dbo];

