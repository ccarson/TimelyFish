 CREATE PROCEDURE smEmpArea_AreaID_EmployeeID
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM smEmpArea
	WHERE AreaID LIKE @parm1
	   AND EmployeeID LIKE @parm2
	ORDER BY AreaID,
	   EmployeeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpArea_AreaID_EmployeeID] TO [MSDSL]
    AS [dbo];

