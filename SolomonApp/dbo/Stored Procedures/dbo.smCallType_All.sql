 CREATE PROCEDURE
	smCallType_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smCallTypes
	WHERE
		CallTypeId LIKE @parm1
	ORDER BY
		CallTypeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCallType_All] TO [MSDSL]
    AS [dbo];

