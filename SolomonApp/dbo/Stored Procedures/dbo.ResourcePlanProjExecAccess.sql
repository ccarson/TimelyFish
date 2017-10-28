
Create PROC [dbo].[ResourcePlanProjExecAccess] @CpnyID VarChar(10), @Project VarChar(16)
AS
    SELECT p.*
    FROM PJPENTEMPLN p JOIN PJProj j
                        ON p.Project = j.project
                       AND j.CpnyId = @CpnyID
	WHERE p.Project = @Project 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ResourcePlanProjExecAccess] TO [MSDSL]
    AS [dbo];

