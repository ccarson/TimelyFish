 CREATE PROC ARRev_CustID_RefNbr3 @parm1 varchar(10), @parm2 varchar(15), @parm3 varchar(10), @parm4 varchar(2) AS
SELECT *
  FROM ARDoc
 WHERE CpnyId = @parm1
   AND CustID = @parm2
   AND refnbr  = @parm3
   AND Rlsed = 1
   AND Doctype like @parm4
   AND Doctype IN ('PA','PP','CM','SB')

ORDER BY Doctype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_CustID_RefNbr3] TO [MSDSL]
    AS [dbo];

