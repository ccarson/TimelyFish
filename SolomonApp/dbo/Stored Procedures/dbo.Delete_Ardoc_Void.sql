 /****** Object:  Stored Procedure dbo.Delete_ARdoc_Void    Script Date: 01/31/00 ******/
CREATE PROC Delete_Ardoc_Void @parm1 VARCHAR (15), @parm2 VARCHAR (2), @parm3 VARCHAR (10), @Parm4 VARCHAR(10) AS
DELETE  ARDoc
	FROM ARDoc
	WHERE
             ARDoc.CustId  = @parm1  and
             ARDoc.DocType = @parm2 and
       	     ARDoc.RefNbr  = @parm3  and
             ARDoc.Batnbr  = @Parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_Ardoc_Void] TO [MSDSL]
    AS [dbo];

