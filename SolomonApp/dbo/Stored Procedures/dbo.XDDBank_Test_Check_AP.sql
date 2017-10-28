
CREATE PROCEDURE XDDBank_Test_Check_AP
   @CpnyIDAcctSub	varchar(44)
AS
   SELECT		Count(*)
   FROM			XDDBank (NoLock)
   WHERE		Test = 'Y'
			and CpnyID + Acct + Sub <> @CpnyIDAcctSub
