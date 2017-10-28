 /****** Object:  Stored Procedure dbo.piheader_inprocess    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure piheader_inprocess @parm1 VarChar(10) As
    select * from piheader
    where piid like @parm1 and status = 'I'
    order by piid desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[piheader_inprocess] TO [MSDSL]
    AS [dbo];

