 /****** Object:  Stored Procedure dbo.APDoc_DocClass_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_DocClass_RefNbr @parm1 varchar ( 1), @parm2 varchar ( 10) as
Select * from APDoc where DocClass = @parm1
and RefNbr like @parm2 order by DocClass, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_DocClass_RefNbr] TO [MSDSL]
    AS [dbo];

