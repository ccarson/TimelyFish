 CREATE PROCEDURE
	smSvcInterval_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSvcInterval
	WHERE
		IntervalCode LIKE @parm1
	ORDER BY
		IntervalCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


