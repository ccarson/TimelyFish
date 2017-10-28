 CREATE PROCEDURE smFaultDetail_FlatRateId
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smFaultDetail
	left outer join smCode
		on smFaultDetail.FaultId = smCode.Fault_Id
WHERE smFaultDetail.FlatRateId = @parm1
	AND smFaultDetail.FaultId LIKE @parm2
ORDER BY smFaultDetail.FlatRateId
	,smFaultDetail.FaultId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFaultDetail_FlatRateId] TO [MSDSL]
    AS [dbo];

