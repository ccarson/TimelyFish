 CREATE PROCEDURE smZipLicense_LicID
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smZipLicense
	left outer join smZipCode
		on smZipLicense.ZipID = smZipCode.ZipId
WHERE smZipLicense.LicenseID = @parm1
	AND smZipLicense.ZipID LIKE @parm2
ORDER BY smZipLicense.LicenseID
	,smZipLicense.ZipID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smZipLicense_LicID] TO [MSDSL]
    AS [dbo];

