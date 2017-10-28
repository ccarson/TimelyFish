 /****** Object:  Stored Procedure dbo.DocTerms_DEL_DocType_RefNbr    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc DocTerms_DEL_DocType_RefNbr @parm1 varchar ( 2), @parm2 varchar( 10) As
     Delete from DocTerms
         Where DocType = @parm1
           and RefNbr  = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DocTerms_DEL_DocType_RefNbr] TO [MSDSL]
    AS [dbo];

