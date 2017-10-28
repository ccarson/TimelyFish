 CREATE PROCEDURE
	smZip_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smZipCode
	WHERE
		ZipId LIKE @parm1
	ORDER BY
		ZipId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smZip_All] TO [MSDSL]
    AS [dbo];

