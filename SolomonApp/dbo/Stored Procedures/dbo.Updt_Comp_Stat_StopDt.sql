 --bkb 7/20/99 4.2
--11500
Create Procedure Updt_Comp_Stat_StopDt @parm1 smalldatetime, @parm2 varchar ( 1),  @parm3 varchar ( 30),
	@parm4 varchar ( 10), @parm5 varchar ( 1), @parm6 smallint,
 	@parm7 smalldatetime, @parm8 varchar (8), @parm9 varchar (10) as
		Update component set
			stopdate = @parm1,
			status = @parm2,
			LUpd_DateTime = @parm7,
			LUpd_Prog = @parm8,
			LUpd_User = @parm9
		where kitid = @parm3
			and kitsiteid = @parm4
			and kitstatus = @parm5
			and linenbr = @parm6


