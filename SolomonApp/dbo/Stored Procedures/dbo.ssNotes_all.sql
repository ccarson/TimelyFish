
CREATE PROCEDURE
	ssNotes_all
		@parm1	varchar(7)
		,@parm2	varchar(30)
AS
	SELECT
		*
	FROM
		ssNotes
	WHERE
		ScreenID LIKE @parm1
	   		AND
	   	PrimaryKey LIKE @parm2
	ORDER BY
		ScreenID
		,PrimaryKey

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ssNotes_all] TO [MSDSL]
    AS [dbo];

