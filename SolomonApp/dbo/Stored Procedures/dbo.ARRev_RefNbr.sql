 /****** Object:  Stored Procedure dbo.ARRev_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROC ARRev_RefNbr @parm1 varchar(10), @parm2 varchar(10) AS
SELECT *
  FROM ARDoc
 WHERE CpnyId = @parm1
   AND refnbr = @parm2
   AND Rlsed = 1
   AND Doctype IN ('PA','PP','CM','SB')
ORDER BY CustID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_RefNbr] TO [MSDSL]
    AS [dbo];

