 CREATE PROCEDURE
	smZipLicense_ZipID_Emp
		@parm1	varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smZipLicense
		,smLicense
	WHERE
		smZipLicense.ZipID = @parm1
			AND
		smZipLicense.licenseid = smLicense.LicenseID
			AND
		smLicense.LicenseType = 'E'
			AND
		smZipLicense.LicenseID LIKE @parm2
	ORDER BY
		smZipLicense.ZipID
		,smZipLicense.LicenseID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smZipLicense_ZipID_Emp] TO [MSDSL]
    AS [dbo];

