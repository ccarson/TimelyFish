 --11260
create procedure RtgStep_Update_StepNbr @parm1 varchar (30),
	@parm2 varchar (10), @parm3 varchar (1), @parm4 integer,
	@parm5 varchar (5) as
	Update RtgStep set StepNbr = @parm5
	where
		KitId = @parm1 and
		Siteid = @parm2 and
		RtgStatus = @parm3 and
		LineNbr = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RtgStep_Update_StepNbr] TO [MSDSL]
    AS [dbo];

