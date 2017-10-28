 CREATE Procedure PROJECT_ACTIVE @Parm1 Varchar(16) As             
	select  project from PJPROJ where project like @parm1 and status_pa = 'A' 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PROJECT_ACTIVE] TO [MSDSL]
    AS [dbo];

