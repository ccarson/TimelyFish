
Create PROC ws_ProjectExecAccessRights @CpnyID VarChar(10), @Employee VarChar(10), @SLUser Varchar(50)
AS
    SELECT p.*
      FROM PJEMPLOY p
     WHERE user_id = @SLUser
       AND CpnyId = @CpnyID 
       AND employee = @Employee
       AND projExec = 1

