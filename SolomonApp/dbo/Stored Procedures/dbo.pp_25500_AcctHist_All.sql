 CREATE PROC pp_25500_AcctHist_All @parm1 varchar(10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10), @parm5 varchar ( 4) as
SELECT * from AcctHist parm1
WHERE        CpnyID     = @parm1 AND
             Acct       = @parm2 AND
             Sub        = @parm3 AND
             LedgerID   = @parm4 AND
             FiscYr     = @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_25500_AcctHist_All] TO [MSDSL]
    AS [dbo];

