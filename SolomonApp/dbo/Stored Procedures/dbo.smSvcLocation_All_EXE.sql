 CREATE PROCEDURE
	smSvcLocation_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSvcLocation
	WHERE
		LocationCode LIKE @parm1
	ORDER BY
		LocationCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


