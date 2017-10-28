 CREATE PROCEDURE PIHeader_Status
	@parm1 varchar( 1 )
AS
	SELECT *
	FROM PIHeader
	WHERE Status LIKE @parm1
	ORDER BY Status

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


