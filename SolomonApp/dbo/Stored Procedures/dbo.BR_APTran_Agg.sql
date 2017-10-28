 CREATE Procedure BR_APTran_Agg
@parm1 char(10),
@parm2 char(6),
@parm3 char(6),
@parm4 char(10),
@parm5 char(24)
as

SELECT APTran.*
FROM APTran
JOIN APDoc ON APDoc.BatNbr = APTran.BatNbr AND APDoc.RefNbr = APTran.RefNbr AND APDoc.Status <> 'V'
WHERE APTran.CpnyID = @parm1 and APTran.PerPost BETWEEN @parm2 and @parm3
AND APTran.Acct = @parm4
AND APTran.Rlsed = 1
ORDER BY APTran.PerPost, APTran.Acct, APTran.Sub


GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_APTran_Agg] TO [MSDSL]
    AS [dbo];

