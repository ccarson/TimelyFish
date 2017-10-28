 Create Procedure Kit_Initialize_type
	@parm1 smalldatetime,
	@parm2 varchar (8),
	@parm3 varchar (10)
	as
	Update Kit set BomType = 'N',
		LUpd_DateTime = @parm1,
		LUpd_Prog = @parm2,
		LUpd_User = @parm3
	where Status <> 'O'




GO
GRANT CONTROL
    ON OBJECT::[dbo].[Kit_Initialize_type] TO [MSDSL]
    AS [dbo];

