 CREATE PROCEDURE BR_BRBankTran_All
@parm1 As varchar(10),
@parm2 As varchar(6),
@parm3 As smallint,
@parm4 As smallint
AS
SELECT *
FROM BRBankTran
WHERE AcctId = @parm1
AND CurrPerNbr = @parm2
AND LineNbr BETWEEN @parm3 AND @parm4
ORDER BY AcctId, CurrPerNbr, LineNbr


