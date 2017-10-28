
CREATE PROCEDURE XDDBank_Test_Check_AR
   @CpnyIDAcctSub	varchar(44)
AS
   SELECT		Count(*)
   FROM			XDDBank (NoLock)
   WHERE		ARTest = 'Y'
			and CpnyID + Acct + Sub <> @CpnyIDAcctSub
