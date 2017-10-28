create procedure PJEMPLOYXREFMSP_update 
	@Employee			char(10),
	@Employee_MSPName	Char(60),		
	@ProjectManager		char(1),
	@WindowsUserAcct	char(85),
	@lupd_user			char(8),
	@lupd_prog			char(6)
as	
	Update PJEMPLOYXREFMSP 
		set Employee_MSPName = @Employee_MSPName, 
			ProjectManager = @ProjectManager, 
			WindowsUserAcct =  @WindowsUserAcct, 
			lupd_datetime = getdate(),
			lupd_user = @lupd_user,
			lupd_prog = @lupd_prog
	WHERE Employee = @Employee 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEMPLOYXREFMSP_update] TO [MSDSL]
    AS [dbo];

