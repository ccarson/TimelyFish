 CREATE PROCEDURE smEmpLicense_Emp
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smEmpLicense
	left outer join smLicense
		on smemplicense.licenseid = smLicense.LicenseID
WHERE smEmpLicense.EmployeeId = @parm1
	AND smEmpLicense.LicenseID LIKE @parm2
ORDER BY smEmpLicense.EmployeeId
	,smEmpLicense.LicenseID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmpLicense_Emp] TO [MSDSL]
    AS [dbo];

