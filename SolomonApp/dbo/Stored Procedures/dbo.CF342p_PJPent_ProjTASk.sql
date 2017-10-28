CREATE PROCEDURE CF342p_PJPent_ProjTASk 
	@parm1 varchar (16), @parm2 varchar (32) 
	AS 
	SELECT * FROM PJPent 
	WHERE Project = @parm1 
	AND Pjt_Entity = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF342p_PJPent_ProjTASk] TO [MSDSL]
    AS [dbo];

