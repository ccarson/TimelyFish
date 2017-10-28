 CREATE PROCEDURE BR_BRBankTran_Unmatch
@parm1 As varchar(10),
@parm2 As varchar(10),
@parm3 As varchar(6),
@parm4 As smallint,
@parm5 As smallint
AS
SELECT *
FROM BRBankTran
WHERE cpnyid = @parm1 and AcctId = @parm2
AND CurrPerNbr = @parm3
AND LineNbr BETWEEN @parm4 AND @parm5
AND BookRefNbr = ''
ORDER BY AcctId, CurrPerNbr, LineNbr


