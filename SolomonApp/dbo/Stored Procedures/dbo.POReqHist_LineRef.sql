 CREATE PROCEDURE POReqHist_LineRef
	@parm1 varchar( 5 )
AS
	SELECT *
	FROM POReqHist
	WHERE LineRef LIKE @parm1
	ORDER BY LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


