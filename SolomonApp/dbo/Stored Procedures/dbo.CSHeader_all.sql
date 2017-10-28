 CREATE PROCEDURE CSHeader_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM CSHeader
	WHERE StmntID LIKE @parm1
	   AND TranRef LIKE @parm2
	ORDER BY StmntID,
	   TranRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


