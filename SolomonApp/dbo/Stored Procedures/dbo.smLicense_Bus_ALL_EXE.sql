 CREATE PROCEDURE
	smLicense_Bus_ALL_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smLicense
	WHERE
		LicenseType = 'B'
			AND
		LicenseID LIKE @parm1
	ORDER BY
		LicenseID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smLicense_Bus_ALL_EXE] TO [MSDSL]
    AS [dbo];

