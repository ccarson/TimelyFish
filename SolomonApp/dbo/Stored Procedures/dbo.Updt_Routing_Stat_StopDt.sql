 --bkb 6/29/99 4.2
--11500
Create Procedure Updt_Routing_Stat_StopDt @parm1 varchar ( 1), @parm2 smalldatetime, @parm3 varchar ( 30),
	@parm4 varchar ( 10), @parm5 varchar ( 1),
	@parm6 smalldatetime, @parm7 varchar (8), @parm8 varchar (10) as
		Update Routing set
			status = @parm1,
			stopdate = @parm2,
			LUpd_DateTime = @parm6,
			LUpd_Prog = @parm7,
			LUpd_User = @parm8
		where kitid = @parm3
			and siteid = @parm4
			and status = @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Updt_Routing_Stat_StopDt] TO [MSDSL]
    AS [dbo];

