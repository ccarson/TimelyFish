
CREATE PROCEDURE GetEmployeeInfo @SLUser VARCHAR(50)
AS
    DECLARE @ReturnTable TABLE (
      recType VARCHAR(50),
      recData VARCHAR(50))
    DECLARE @EmpID VARCHAR(50)
    DECLARE @EmpGet VARCHAR(50)
    DECLARE @ProjGet VARCHAR(50)
    DECLARE @BadCount SMALLINT

    SELECT @BadCount = Count(*)
    FROM   PJEMPLOY
    WHERE  PJEMPLOY.user_id = @SLUser

    IF @BadCount = 0
      GOTO FINISH

    --Get Employee ID and put in Return Table
    INSERT INTO @ReturnTable
    VALUES      ('EMPID',
                 (SELECT Employee
                  FROM   PJEMPLOY
                  WHERE  PJEMPLOY.user_id = @SLUser))

    SELECT @EmpID = Employee
    FROM   PJEMPLOY
    WHERE  PJEMPLOY.user_id = @SLUser

    --Get Project Employee Name
    INSERT INTO @ReturnTable
    VALUES      ('EMPNAME',
                 (SELECT emp_name
                  FROM   PJEMPLOY
                  WHERE  PJEMPLOY.user_id = @SLUser))
                  
     --Get Company ID
    INSERT INTO @ReturnTable
    VALUES      ('CPNYID',
                 (SELECT CpnyId
                  FROM   PJEMPLOY
                  WHERE  PJEMPLOY.user_id = @SLUser))               

    --Get Project Executive Flag
    INSERT INTO @ReturnTable
    VALUES      ('PROJEXEC',
                 (SELECT projExec
                  FROM   PJEMPLOY
                  WHERE  PJEMPLOY.user_id = @SLUser))

    --Get Supervisor Employees and put in Return Table
    DECLARE empSupCsr CURSOR FOR
      SELECT Employee
      FROM   PJEMPLOY
      WHERE  PJEMPLOY.manager1 = @EmpID

    OPEN empSupCsr

    FETCH empSupCsr INTO @EmpGet

    WHILE @@FETCH_STATUS = 0
      BEGIN
          INSERT INTO @ReturnTable
          VALUES      ('EMPSUP',
                       @EmpGet)

          FETCH empSupCsr INTO @EmpGet
      END

    CLOSE empSupCsr

    DEALLOCATE empSupCsr

    --Get Manager Employees and put in Return Table
    DECLARE empManCsr CURSOR FOR
      SELECT Employee
      FROM   PJEMPLOY
      WHERE  PJEMPLOY.manager2 = @EmpID

    OPEN empManCsr

    FETCH empManCsr INTO @EmpGet

    WHILE @@FETCH_STATUS = 0
      BEGIN
          INSERT INTO @ReturnTable
          VALUES      ('EMPMAN',
                       @EmpGet)

          FETCH empManCsr INTO @EmpGet
      END

    CLOSE empManCsr

    DEALLOCATE empManCsr

    --Get Manager Projects and put in Return Table
    DECLARE projManCsr CURSOR FOR
      SELECT Project
      FROM   PJPROJ
      WHERE  PJPROJ.manager1 = @EmpID

    OPEN projManCsr

    FETCH projManCsr INTO @ProjGet

    WHILE @@FETCH_STATUS = 0
      BEGIN
          INSERT INTO @ReturnTable
          VALUES      ('PROJMAN',
                       @ProjGet)

          FETCH projManCsr INTO @ProjGet
      END

    CLOSE projManCsr

    DEALLOCATE projManCsr

    --Get Business Manager Projects and put in Return Table
    DECLARE projBusCsr CURSOR FOR
      SELECT Project
      FROM   PJPROJ
      WHERE  PJPROJ.manager2 = @EmpID

    OPEN projBusCsr

    FETCH projBusCsr INTO @ProjGet

    WHILE @@FETCH_STATUS = 0
      BEGIN
          INSERT INTO @ReturnTable
          VALUES      ('PROJBUS',
                       @ProjGet)

          FETCH projBusCsr INTO @ProjGet
      END

    CLOSE projBusCsr

    DEALLOCATE projBusCsr

    --Return Data Found
    SELECT *
    FROM   @ReturnTable

    FINISH:

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GetEmployeeInfo] TO [MSDSL]
    AS [dbo];

