 CREATE PROCEDURE
	smServFault_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smServFault
	WHERE
		ServiceCallID LIKE @parm1
	ORDER BY
		ServiceCallID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


