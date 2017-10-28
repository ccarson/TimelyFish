 CREATE PROCEDURE POReqHist_UserID
	@parm1 varchar( 47 )
AS
	SELECT *
	FROM POReqHist
	WHERE UserID LIKE @parm1
	ORDER BY UserID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


