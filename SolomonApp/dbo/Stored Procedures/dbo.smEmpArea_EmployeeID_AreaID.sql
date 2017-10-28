 CREATE PROCEDURE smEmpArea_EmployeeID_AreaID
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM smEmpArea
	WHERE EmployeeID LIKE @parm1
	   AND AreaID LIKE @parm2
	ORDER BY EmployeeID,
	   AreaID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpArea_EmployeeID_AreaID] TO [MSDSL]
    AS [dbo];

