 CREATE PROCEDURE smSubFRTable_FlatRateId
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smSubFRTable
	left outer join ProductClass
		on smSubFRTable.ClassID = ProductClass.ClassId
WHERE FlatRateId = @parm1
	AND smSubFRTable.ClassID LIKE @parm2
ORDER BY smSubFRTable.FlatRateId
	,smSubFRTable.ClassID


