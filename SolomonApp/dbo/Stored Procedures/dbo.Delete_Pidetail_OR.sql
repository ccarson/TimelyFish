 /****** Object:  Stored Procedure dbo.Delete_Pidetail_OR    Script Date: 4/17/98 10:58:17 AM ******/
Create Proc Delete_Pidetail_OR @Parm1 Varchar(10) as
	Delete From PIDetail Where PIID = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_Pidetail_OR] TO [MSDSL]
    AS [dbo];

