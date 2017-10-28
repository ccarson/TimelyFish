 CREATE PROCEDURE smLBDetail_WrkLBDetail
			@parm1 smalldatetime
			,@parm2 smalldatetime
AS
SELECT * FROM smLBDETAIL
	WHERE
		TranDate >= @parm1 AND
		TranDate <= @parm2
	ORDER BY
		ServiceCallID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


