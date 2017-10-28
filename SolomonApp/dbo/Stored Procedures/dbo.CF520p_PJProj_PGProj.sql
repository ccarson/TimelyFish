Create Procedure CF520p_PJProj_PGProj @parm1 varchar (2), @parm2 varchar (16) as 
    Select * from PJProj Where Left(Project, 2) = @parm1 and Project Like @parm2
	Order by Project

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_PJProj_PGProj] TO [MSDSL]
    AS [dbo];

