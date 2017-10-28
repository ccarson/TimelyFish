 CREATE PROCEDURE smCodeLicense_Fault_Id
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smCodeLicense
	left outer join smLicense
		on smCodeLicense.LicenseID = smLicense.LicenseID
WHERE Fault_Id = @parm1
	AND smCodeLicense.LicenseID LIKE @parm2
ORDER BY smCodeLicense.Fault_Id, smCodeLicense.LicenseID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCodeLicense_Fault_Id] TO [MSDSL]
    AS [dbo];

