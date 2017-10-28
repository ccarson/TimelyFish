 --bkb 6/29/99 4.2
--11500
Create Procedure Updt_Comp_SubKitStat @parm1 varchar ( 1), @parm2 varchar ( 30), @parm3 varchar ( 10),
	@parm4 smalldatetime, @parm5 varchar (8), @parm6 varchar (10) as
		Update Component set
			subkitstatus = @parm1,
			LUpd_DateTime = @parm4,
			LUpd_Prog = @parm5,
			LUpd_User = @parm6
		where cmpnentid = @parm2
			and siteid = @parm3


