 CREATE  PROCEDURE CuryAcct_Cash
@Parm1 VARCHAR(10),
@Parm2 VARCHAR(10),
@Parm3 VARCHAR(24),
@Parm4 VARCHAR(10),
@Parm5 VARCHAR(4),
@Parm6 VARCHAR(4)
AS
SELECT * FROM CuryAcct
         WHERE CpnyID = @Parm1
               AND Acct   = @Parm2
               AND Sub    = @Parm3
               AND LedgerID = @Parm4
               AND FiscYr = @Parm5
               AND CuryID = @Parm6


