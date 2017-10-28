 CREATE PROCEDURE
	smDispatcherNotes_All
		@parm1	varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smDispatcherNotes
	WHERE
		CallType LIKE @parm1
			AND
		GeographicID LIKE @parm2
	ORDER BY
		CallType
		,GeographicID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smDispatcherNotes_All] TO [MSDSL]
    AS [dbo];

