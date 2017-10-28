 --bkb 7/20/99 4.2
--11500
Create Procedure Updt_Comp_Stat @parm1 varchar ( 1), @parm2 varchar ( 30), @parm3 varchar ( 10),
	@parm4 varchar ( 1), @parm5 smallint, @parm6 smalldatetime,
	@parm7 varchar (8), @parm8 varchar (10) as
		Update component set
			status = @parm1,
			LUpd_DateTime = @parm6,
			LUpd_Prog = @parm7,
			LUpd_User = @parm8
		where kitid = @parm2
			and kitsiteid = @parm3
			and kitstatus = @parm4
			and linenbr = @parm5


