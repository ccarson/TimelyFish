 /****** Object:  Stored Procedure dbo.pidetail_piid    Script Date: 4/17/98 10:58:19 AM ******/
Create Procedure pidetail_piid @parm1 varchar(10), @parm2beg int, @parm2end int As
    select * from pidetail
    where piid = @parm1
    and linenbr between @parm2beg and @parm2end
    order by piid, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pidetail_piid] TO [MSDSL]
    AS [dbo];

