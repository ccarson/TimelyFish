 CREATE PROCEDURE SOLine_InvtID_Status
	@parm1 varchar( 30 ),
	@parm2 varchar( 1 )
AS
	SELECT *
	FROM SOLine
	WHERE InvtID LIKE @parm1
	   AND Status LIKE @parm2
	ORDER BY InvtID,
	   Status

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


