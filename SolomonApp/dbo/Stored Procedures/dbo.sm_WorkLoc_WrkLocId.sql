 CREATE PROCEDURE
	sm_WorkLoc_WrkLocId
		@parm1 varchar(6)
AS
	SELECT
		*
	FROM
		WorkLoc
	WHERE
		WrkLocId LIKE @parm1
	ORDER BY
		WrkLocId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


