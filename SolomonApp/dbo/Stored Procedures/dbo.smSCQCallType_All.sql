 CREATE PROCEDURE smSCQCallType_All
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smSCQCallType
	left outer join smCallTypes
		on smSCQCallType.CallType = smCallTypes.CallTypeId
WHERE ConfigCode = @parm1
	AND CallType LIKE @parm2
ORDER BY ConfigCode
	,CallType


