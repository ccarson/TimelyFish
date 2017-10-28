 CREATE PROCEDURE p08990InsAr_Balances @UserAddress VARCHAR(21), @CurrPer varchar (6) AS

INSERT AR_Balances (AccruedRevAgeBal00, AccruedRevAgeBal01, AccruedRevAgeBal02, AccruedRevAgeBal03, AccruedRevAgeBal04, AccruedRevBal,
	AgeBal00, AgeBal01, AgeBal02, AgeBal03, AgeBal04, AvgDayToPay, CpnyID, CrLmt, Crtd_DateTime,
	Crtd_Prog, Crtd_User, CurrBal, CuryID, CuryPromoBal, CustID, FutureBal, LastActDate, LastAgeDate, LastFinChrgDate,
	LastInvcDate, LastStmtBal00, LastStmtBal01, LastStmtBal02, LastStmtBal03, LastStmtBal04, LastStmtBegBal,
	LastStmtDate, LUpd_DateTime, LUpd_Prog, LUpd_User, NbrInvcPaid, NoteID, PaidInvcDays, PerNbr, PromoBal, S4Future01,
	S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
	S4Future11, S4Future12, TotOpenOrd, TotPrePay, TotShipped, User1, User2, User3, User4, User5, User6, User7, User8)
SELECT DISTINCT 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, d.CpnyID, 0, GETDATE(), '08990', @UserAddress, 0, '', 0, d.CustID, 0, '', '', '', '',
	0, 0, 0, 0, 0, 0, '', GETDATE(), '08990', @UserAddress, 0, 0, 0, @CurrPer, 0, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
	0, 0, 0, '', '', 0, 0, '', '', '', ''

from ardoc d
left outer join ar_balances b on
d.cpnyid = b.cpnyid and d.custid = b.custid
where b.cpnyid is null and b.custid is null



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990InsAr_Balances] TO [MSDSL]
    AS [dbo];

