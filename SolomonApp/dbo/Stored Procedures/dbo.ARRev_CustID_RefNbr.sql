 /****** Object:  Stored Procedure dbo.ARRev_CustID_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROC ARRev_CustID_RefNbr @parm1 varchar(10), @parm2 varchar(15), @parm3 varchar(10) AS
SELECT *
  FROM ARDoc
 WHERE CpnyId = @parm1
   AND CustID = @parm2
   AND refnbr  = @parm3
   AND Rlsed = 1
   AND Doctype IN ('PA','PP','CM','SB')
ORDER BY Doctype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARRev_CustID_RefNbr] TO [MSDSL]
    AS [dbo];

