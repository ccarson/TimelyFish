 CREATE PROCEDURE PODeptAppr_DeptID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM PODeptAppr
	WHERE DeptID LIKE @parm1
	ORDER BY DeptID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


