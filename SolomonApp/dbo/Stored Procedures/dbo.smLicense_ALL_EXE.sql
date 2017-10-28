 CREATE PROCEDURE
	smLicense_ALL_EXE
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smLicense
	WHERE
		LicenseID LIKE @parm1
	ORDER BY
		LicenseID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


