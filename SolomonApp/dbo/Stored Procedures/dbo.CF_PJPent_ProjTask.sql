--*************************************************************
--	Purpose:Task
--	Author: Charity Anderson
--	Date: 10/21/2004
--	Usage: Pig Sales Entry		 
--	Parms: project, pjt_entity
--*************************************************************

CREATE PROC dbo.CF_PJPent_ProjTask
	(@parm1 as varchar(16), @parm2 as varchar(32))
AS
Select * from PJPENT where project = @parm1 and pjt_entity = @parm2 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF_PJPent_ProjTask] TO [MSDSL]
    AS [dbo];

