 CREATE PROCEDURE
	smState_All_EXE
		@parm1	varchar(3)
AS
	SELECT
		*
	FROM
		State
	WHERE
		StateProvId LIKE @parm1
	ORDER BY
		StateProvId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


