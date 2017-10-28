 CREATE PROCEDURE POReqDet_Status
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM POReqDet
	WHERE Status LIKE @parm1
	ORDER BY Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


