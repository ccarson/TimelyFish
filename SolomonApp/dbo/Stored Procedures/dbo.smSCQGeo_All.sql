 CREATE PROCEDURE smSCQGeo_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smSCQGeo
	left outer join smArea
		on smSCQGeo.GeographicID = smArea.AreaId
WHERE ConfigCode = @parm1
	AND GeographicID LIKE @parm2
ORDER BY ConfigCode
	,GeographicID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smSCQGeo_All] TO [MSDSL]
    AS [dbo];

