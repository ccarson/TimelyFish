 CREATE PROCEDURE PODeptAppr_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 2 ),
	@parm3 varchar( 2 ),
	@parm4 varchar( 1 ),
	@parm5 varchar( 2 ),
	@parm6min smalldatetime, @parm6max smalldatetime
AS
	SELECT *
	FROM PODeptAppr
	WHERE DeptID LIKE @parm1
	   AND DocType LIKE @parm2
	   AND RequestType LIKE @parm3
	   AND Budgeted LIKE @parm4
	   AND Authority LIKE @parm5
	   AND EffDate BETWEEN @parm6min AND @parm6max
	ORDER BY DeptID,
	   DocType,
	   RequestType,
	   Budgeted,
	   Authority,
	   EffDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


