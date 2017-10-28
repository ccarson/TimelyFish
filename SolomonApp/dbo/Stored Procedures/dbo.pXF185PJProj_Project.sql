CREATE PROCEDURE pXF185PJProj_Project 
	@parm1 varchar (16) 
	AS 
    	SELECT * 
	FROM PJProj 
	WHERE Project = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185PJProj_Project] TO [MSDSL]
    AS [dbo];

