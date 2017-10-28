Create Procedure CF300p_PJProj_Project @parm1 varchar (16) as 
    Select * from PJProj Where Project = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_PJProj_Project] TO [MSDSL]
    AS [dbo];

