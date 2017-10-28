 /****** Object:  Stored Procedure dbo.Delete_PIDetail    Script Date: 4/17/98 10:58:17 AM ******/
Create Proc Delete_PIDetail @parm1 VarChar(6) as
    Delete from PIDetail where PerClosed <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_PIDetail] TO [MSDSL]
    AS [dbo];

