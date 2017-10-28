 CREATE PROCEDURE
	smEqConfig_ServiceCallId
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smEqConfig
	WHERE
		ServiceCallId LIKE @parm1
	ORDER BY
		ServiceCallId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEqConfig_ServiceCallId] TO [MSDSL]
    AS [dbo];

