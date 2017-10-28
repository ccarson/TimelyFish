 CREATE PROCEDURE SO40125_Wrk_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM SO40125_Wrk
	WHERE SlsperID LIKE @parm1
	ORDER BY SlsperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


