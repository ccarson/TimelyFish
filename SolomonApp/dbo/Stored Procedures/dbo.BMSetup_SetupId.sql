 Create Procedure BMSetup_SetupId @parm1 varchar ( 2) as
	Select * from BMSetup where
		SetupId like @parm1
		order by SetupId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMSetup_SetupId] TO [MSDSL]
    AS [dbo];

