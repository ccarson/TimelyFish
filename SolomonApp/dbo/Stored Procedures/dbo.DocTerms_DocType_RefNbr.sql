 /****** Object:  Stored Procedure dbo.DocTerms_DocType_RefNbr    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc  DocTerms_DocType_RefNbr
@parm1 varchar ( 2), @parm2 varchar ( 10), @parm3beg smallint, @parm3end smallint as
       Select * from DocTerms
           where DocType = @parm1
             and RefNbr  = @parm2
             and LineNbr BETWEEN @parm3beg and @parm3end
           order by LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DocTerms_DocType_RefNbr] TO [MSDSL]
    AS [dbo];

