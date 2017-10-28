 CREATE PROCEDURE smJobGeo_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smJobGeo
	left outer join smArea
		on smJobGeo.GeographicID = smArea.AreaId
WHERE ConfigCode = @parm1
	AND GeographicID LIKE @parm2
ORDER BY ConfigCode
	 ,GeographicID


