 CREATE PROCEDURE
	sm_EarnType_Id
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		EarnType
	WHERE
		Id LIKE @parm1
	ORDER BY
		Id

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


