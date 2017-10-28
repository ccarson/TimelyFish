CREATE PROCEDURE XDDEmployee_EmpID
  @EmpID      varchar(10)
AS
  Select      *
  FROM        Employee
  WHERE       EmpID LIKE @EmpID
