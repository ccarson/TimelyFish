 CREATE PROCEDURE
	smMark_All_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smMark
	WHERE
		MarkupId LIKE @parm1
	ORDER BY
		MarkupId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


