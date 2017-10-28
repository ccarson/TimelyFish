
CREATE PROCEDURE XDDBank_Test_MultiCpny
AS
   SELECT		Count(Distinct CpnyID)
   FROM			XDDBank (NoLock)
   WHERE		FormatID = 'US-ACH'
