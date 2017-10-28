 CREATE PROCEDURE smJobCallType_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smJobCallType
	left outer join smCallTypes
		on mJobCallType.CallType = smCallTypes.CallTypeId
WHERE ConfigCode = @parm1
	AND CallType LIKE @parm2
ORDER BY ConfigCode
	,CallType


