 CREATE PROCEDURE BR_BRBookRef
@parm1 varchar(10),
@parm2 varchar(8),
@parm3 varchar(10)
AS
SELECT   *
FROM 	   BRTran
WHERE   AcctID = @parm1
AND         CurrPerNbr = @parm2
AND	   OrigRefNbr LIKE @parm3
AND 	   UserC1 = ''
ORDER BY AcctID, CurrPerNbr, OrigRefNbr


