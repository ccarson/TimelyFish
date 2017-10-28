--*************************************************************
--	Purpose:Project
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Sales Entry		 
--	Parms: Project
--*************************************************************

CREATE PROC dbo.CF_PJProj_Project
	(@parm1 as varchar(16))
AS
Select * from PJPROJ where project = @parm1 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_PJProj_Project] TO [MSDSL]
    AS [dbo];

