 CREATE PROCEDURE
	smJobBoard_ServiceCallId
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smJobBoard
	WHERE
		ServiceCallID LIKE @parm1
	ORDER BY
		ServiceCallID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


