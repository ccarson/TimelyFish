
CREATE PROCEDURE WSL_EmployeeAdvance
 @parm1 varchar (10) -- Employee
AS
  SET NOCOUNT ON
  SELECT em_id07 AS EmployeeAdvanceAmount
  FROM PJEMPLOY
  WHERE employee = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_EmployeeAdvance] TO [MSDSL]
    AS [dbo];

