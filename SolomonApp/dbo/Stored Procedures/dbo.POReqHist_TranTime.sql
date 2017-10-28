 CREATE PROCEDURE POReqHist_TranTime
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POReqHist
	WHERE TranTime LIKE @parm1
	ORDER BY TranTime

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


