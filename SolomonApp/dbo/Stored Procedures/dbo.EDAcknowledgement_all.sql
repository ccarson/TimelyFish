 CREATE PROCEDURE EDAcknowledgement_all
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM EDAcknowledgement
	WHERE AcknowledgementID BETWEEN @parm1min AND @parm1max
	ORDER BY AcknowledgementID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


