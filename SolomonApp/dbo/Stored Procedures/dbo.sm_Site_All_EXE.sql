 CREATE PROCEDURE
	sm_Site_All_EXE
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		Site
	WHERE
		SiteId LIKE @parm1
	ORDER BY
		SiteId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


