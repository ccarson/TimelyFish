create PROCEDURE XAPCheck_Insert
@BatNbr char(10), @CheckDate Smalldatetime, @RepFormat varchar(7)
AS 
Delete from XAPCheck where BatNbr = @BatNbr
Insert into XAPCheck (Acct, BatNbr, CheckAmt, CheckLines, CheckNbr, CheckOffset, CheckRefNbr, CheckType, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryCheckAmt, CuryDate, CuryDiscAmt, CuryID, CuryMultDiv, CuryRate, DateEnt, DiscAmt, LUpd_DateTime,
LUpd_Prog, LUpd_User, NoteID, PmtMethod, Printed, RepFormat,S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, Status, Sub, User1, User2, User3, User4, User5,
User6, User7, User8, VendID)
Select Acct, BatNbr, CheckAmt, CheckLines, CheckNbr, CheckOffset, CheckRefNbr, CheckType, CpnyID, @CheckDate, Crtd_Prog, Crtd_User, CuryCheckAmt, CuryDate, CuryDiscAmt, CuryID, CuryMultDiv, CuryRate, DateEnt, DiscAmt, LUpd_DateTime, LUpd_Prog, 
LUpd_User, NoteID, PmtMethod, 1, @RepFormat, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, Status, Sub, User1, User2, User3, User4, User5, User6, User7, User8, 
VendID from APCheck where BatNbr = @BatNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XAPCheck_Insert] TO [MSDSL]
    AS [dbo];

