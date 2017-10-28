 /****** Object:  Stored Procedure dbo.Document_DocType_DocID    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.Document_DocType_DocID    Script Date: 4/7/98 12:51:20 PM ******/
Create Proc Document_DocType_DocID @parm1 varchar ( 1), @parm2 varchar ( 40) as
       Select * from Document
           where DocType  LIKE  @parm1
             and DocID    LIKE  @parm2
           order by DocType,
                    DocID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Document_DocType_DocID] TO [MSDSL]
    AS [dbo];

