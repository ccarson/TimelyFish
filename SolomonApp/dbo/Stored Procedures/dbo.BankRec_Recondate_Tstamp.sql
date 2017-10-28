 CREATE PROC BankRec_Recondate_Tstamp
@Parm1 VARCHAR (10),
@Parm2 VARCHAR (10),
@Parm3 VARCHAR (24)
AS

SELECT *, CONVERT (int, SUBSTRING (tstamp, 1, 4)), CONVERT (int, SUBSTRING (tstamp, 5, 4))

FROM BankRec

WHERE CpnyID LIKE @Parm1 AND
      BankAcct LIKE @Parm2 AND
      BankSub LIKE @Parm3

ORDER BY BankAcct DESC, BankSub DESC, ReconDate DESC


