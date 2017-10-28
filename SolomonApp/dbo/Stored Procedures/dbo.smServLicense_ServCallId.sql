 CREATE PROCEDURE smServLicense_ServCallId
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smServLicense
	left outer join smLicense
		on smServLicense.LicenseID = smLicense.LicenseID
WHERE ServiceCallId = @parm1
	AND smServLicense.LicenseID LIKE @parm2
ORDER BY ServiceCallId
	,smServLicense.LicenseID


