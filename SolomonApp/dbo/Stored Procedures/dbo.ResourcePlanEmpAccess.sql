
Create PROC [dbo].[ResourcePlanEmpAccess] @CpnyID VarChar(10), @Project VarChar(16), @Employee VarChar(10)
AS
    SELECT p.*
      FROM PJPENTEMPLN p JOIN PJProj j
                        ON p.Project = j.project
                       AND j.CpnyId = @CpnyID
     WHERE p.Project = @Project 
       AND p.Employee = @Employee


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ResourcePlanEmpAccess] TO [MSDSL]
    AS [dbo];

