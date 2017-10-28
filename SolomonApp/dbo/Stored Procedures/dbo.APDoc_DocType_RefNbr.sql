 /****** Object:  Stored Procedure dbo.APDoc_DocType_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_DocType_RefNbr @parm1 varchar ( 2), @parm2 varchar ( 10) as
Select * from APDoc where DocType = @parm1
and RefNbr like @parm2
Order by DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_DocType_RefNbr] TO [MSDSL]
    AS [dbo];

