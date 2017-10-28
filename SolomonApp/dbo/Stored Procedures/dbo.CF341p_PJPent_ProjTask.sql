CREATE PROCEDURE CF341p_PJPent_ProjTask @parm1 varchar (16), @parm2 varchar (32) 
	as 
    	SELECT * FROM PJPent 
	WHERE Project = @parm1 
	AND Pjt_Entity = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_PJPent_ProjTask] TO [MSDSL]
    AS [dbo];

