 CREATE PROCEDURE smAreaZips_Area
	@parm1 varchar(10),
	@parm2 varchar(10)
AS
SELECT *
FROM smAreaZips
	left outer join smZipCode
		on smAreaZips.AreaZipCode = smZipCode.ZipId
WHERE AreaZipId = @parm1
	AND AreaZipCode LIKE @parm2
ORDER BY AreaZipId, AreaZipCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smAreaZips_Area] TO [MSDSL]
    AS [dbo];

