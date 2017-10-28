
Create PROC ws_EmployeeAccessRights @CpnyID VarChar(10), @Project VarChar(16), @Employee VarChar(10)
AS
    SELECT p.* 
      FROM PJPROJEM p JOIN PJProj j
                        ON p.Project = j.project
                       AND j.CpnyId = @CpnyID
     WHERE p.project = @Project
       AND (p.employee = @Employee or p.employee = '*')

