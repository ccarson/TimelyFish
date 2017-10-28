 CREATE PROCEDURE
	smComm_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smComm
		WHERE
			CommId LIKE @parm1
		ORDER BY
			CommId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smComm_All] TO [MSDSL]
    AS [dbo];

