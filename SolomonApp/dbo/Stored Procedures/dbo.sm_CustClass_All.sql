 CREATE PROCEDURE
	sm_CustClass_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		CustClass
	WHERE
		ClassId LIKE @parm1
	ORDER BY
		ClassId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


