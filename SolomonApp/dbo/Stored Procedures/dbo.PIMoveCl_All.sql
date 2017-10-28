 /****** Object:  Stored Procedure dbo.PIMoveCl_All    Script Date: 4/17/98 10:58:19 AM ******/
Create proc PIMoveCl_All @Parm1 varchar(10) as
    Select * from PIMoveCl where MoveClass like @parm1
    order by MoveClass



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIMoveCl_All] TO [MSDSL]
    AS [dbo];

