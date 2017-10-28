 Create Procedure Component_Mass_Update
	@parm1 smalldatetime,
	@parm2 smalldatetime,
	@parm3 float (8),
	@parm4 float (8),
	@parm5 float (8),
	@parm6 varchar (1),
	@parm7 smalldatetime,
	@parm8 varchar (8),
	@parm9 varchar (10),
	@parm10 varchar (30),
	@parm11 as varchar (1),
	@parm12 as varchar (10),
	@parm13 as smallint
	AS
    	Update Component set
		startdate = @parm1,
		stopdate = @parm2,
		stdqty = @parm3,
		cmpnentqty = @parm4,
		scrappct = @parm5,
		status = @parm6,
		LUpd_DateTime = @parm7,
		LUpd_Prog = @parm8,
		LUpd_User = @parm9
		Where kitid =  @parm10
			and kitstatus = @parm11
			and kitsiteid = @parm12
			and linenbr = @parm13



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_Mass_Update] TO [MSDSL]
    AS [dbo];

