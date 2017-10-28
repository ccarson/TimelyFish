
Create PROC ResourceAssignProjExecAccess @CpnyID VarChar(10), @Project VarChar(16)
AS
    SELECT p.*
      FROM PJPENTEM p JOIN PJProj j
                        ON p.Project = j.project
                       AND j.CpnyId = @CpnyID
    WHERE p.Project = @Project 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ResourceAssignProjExecAccess] TO [MSDSL]
    AS [dbo];

