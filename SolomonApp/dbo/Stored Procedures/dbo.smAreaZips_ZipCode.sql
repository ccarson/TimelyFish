 CREATE PROCEDURE
	smAreaZips_ZipCode
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smAreaZips
	WHERE
		AreaZipCode LIKE @parm1
	ORDER BY
		AreaZipCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


