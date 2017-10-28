 CREATE PROCEDURE smEmpArea_EmpID_AreaID
	@parm1 varchar( 10 )
AS
	SELECT EmployeeID, AreaID
	FROM smEmpArea
	WHERE EmployeeID = @parm1
	ORDER BY EmployeeID, AreaID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpArea_EmpID_AreaID] TO [MSDSL]
    AS [dbo];

