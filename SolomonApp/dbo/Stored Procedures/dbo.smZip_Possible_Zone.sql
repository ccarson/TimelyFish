 CREATE PROCEDURE
	smZip_Possible_Zone
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smZipCode
	WHERE
		smZipCode.ZipId not in (SELECT AreaZipCode FROM smAreaZips )
			AND
		smZipCode.ZipID LIKE @parm1
	ORDER BY
		smZipCode.ZipID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smZip_Possible_Zone] TO [MSDSL]
    AS [dbo];

