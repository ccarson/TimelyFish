 CREATE PROCEDURE PODeptApprDefer_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 47 ),
	@parm3 varchar( 47 ),
	@parm4min smalldatetime, @parm4max smalldatetime
AS
	SELECT *
	FROM PODeptApprDefer
	WHERE DeptId LIKE @parm1
	   AND UserID LIKE @parm2
	   AND DeferUserID LIKE @parm3
	   AND StartDate BETWEEN @parm4min AND @parm4max
	ORDER BY DeptId,
	   UserID,
	   DeferUserID,
	   StartDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


