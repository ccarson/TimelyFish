CREATE PROCEDURE pXU010PJProj_Project 
	-- CREATED BY: TJones
	-- CREATED ON: 5/20/05
	@ProjectID varchar (16) 
	AS 
    	SELECT * FROM PJProj 
	WHERE Project = @ProjectID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010PJProj_Project] TO [MSDSL]
    AS [dbo];

