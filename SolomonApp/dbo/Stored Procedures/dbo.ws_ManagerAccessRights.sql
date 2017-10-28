
Create PROC ws_ManagerAccessRights @CpnyID VarChar(10), @Project VarChar(16), @Manager VarChar(10)
AS
    SELECT *
      FROM PJProj 
     WHERE Project = @Project 
       AND CpnyId = @CpnyID
       AND (manager1 = @Manager or manager2 = @Manager)

