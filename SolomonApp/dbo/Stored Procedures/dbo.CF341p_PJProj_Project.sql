CREATE PROCEDURE CF341p_PJProj_Project @parm1 varchar (16) 
	as 
    	SELECT * FROM PJProj 
	WHERE Project = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_PJProj_Project] TO [MSDSL]
    AS [dbo];

