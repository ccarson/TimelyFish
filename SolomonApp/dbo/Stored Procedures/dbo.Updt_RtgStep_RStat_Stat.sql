 --bkb 6/29/99 4.2
--11500
Create Procedure Updt_RtgStep_RStat_Stat @parm1 varchar ( 1), @parm2 varchar ( 1), @parm3 varchar ( 30),
	@parm4 varchar ( 10), @parm5 varchar ( 1),
	@parm6 smalldatetime, @parm7 varchar (8), @parm8 varchar (10) as
		Update RtgStep set
			rtgstatus = @parm1,
			status = @parm2,
			LUpd_DateTime = @parm6,
			LUpd_Prog = @parm7,
			LUpd_User = @parm8
		where kitid = @parm3
			and siteid = @parm4
			and rtgstatus = @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Updt_RtgStep_RStat_Stat] TO [MSDSL]
    AS [dbo];

