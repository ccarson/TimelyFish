 CREATE PROCEDURE
	smSCQConfig_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSCQConfig
	WHERE
		ConfigCode LIKE @parm1
	ORDER BY
		ConfigCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


