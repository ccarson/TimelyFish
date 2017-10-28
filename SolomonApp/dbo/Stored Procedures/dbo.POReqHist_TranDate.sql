 CREATE PROCEDURE POReqHist_TranDate
	@parm1min smalldatetime, @parm1max smalldatetime
AS
	SELECT *
	FROM POReqHist
	WHERE TranDate BETWEEN @parm1min AND @parm1max
	ORDER BY TranDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


