
CREATE PROCEDURE GetEmployeeData @EmpID VARCHAR(10)  
AS  
    DECLARE @ReturnTable TABLE (  
      recType VARCHAR(60),  
      recData VARCHAR(60))   
    DECLARE @EmpGet VARCHAR(10)  
    DECLARE @ProjGet VARCHAR(16)   

    --Get Employee ID and put in Return Table  
    INSERT INTO @ReturnTable  
    VALUES      ('EMPID',  
                 (SELECT Employee  
                  FROM   PJEMPLOY  
                  WHERE  PJEMPLOY.employee = @EmpID))  
 
  
    --Get Project Employee Name  
    INSERT INTO @ReturnTable  
    VALUES      ('EMPNAME',  
                 (SELECT emp_name  
                  FROM   PJEMPLOY  
                  WHERE  PJEMPLOY.employee = @EmpID))  
  
    --Get Project Executive Flag  
    INSERT INTO @ReturnTable  
    VALUES      ('PROJEXEC',  
                 (SELECT projExec  
                  FROM   PJEMPLOY  
                  WHERE  PJEMPLOY.employee = @EmpID))  
  
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
    ON OBJECT::[dbo].[GetEmployeeData] TO [MSDSL]
    AS [dbo];

