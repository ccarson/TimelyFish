 CREATE PROCEDURE
	smMedGroup_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smMedGroup
	WHERE
		MediaGroupId LIKE @parm1
	ORDER BY
		MediaGroupId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


