
Create PROC ResourceAssignManagerAccess @CpnyID VarChar(10), @Project VarChar(16), @Manager VarChar(10)
AS
    SELECT p.*
      FROM PJPENTEM p JOIN PJProj j
                        ON p.Project = j.project
                       AND j.CpnyId = @CpnyID
                       AND (j.manager1 = @Manager or j.manager2 = @Manager)
     WHERE p.Project = @Project 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ResourceAssignManagerAccess] TO [MSDSL]
    AS [dbo];

