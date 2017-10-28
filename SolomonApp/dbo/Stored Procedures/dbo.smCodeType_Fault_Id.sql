 CREATE PROCEDURE smCodeType_Fault_Id
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smCodeType
	left outer join smCallTypes
		on smCodeType.CallTypeId = smCallTypes.CallTypeId
WHERE smCodeType.Fault_Id = @parm1
	AND smCodeType.CallTypeId LIKE @parm2
ORDER BY smCodeType.Fault_Id, smCodeType.CallTypeId


