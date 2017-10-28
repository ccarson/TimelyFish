 CREATE PROCEDURE smFaultDetail_FaultId
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smFaultDetail
	left outer join smFlatRate
		on smFaultDetail.FlatRateId = smFlatRate.FlatRateId
WHERE FaultId = @parm1
	AND smFaultDetail.FlatRateId LIKE @parm2
ORDER BY smFaultDetail.FaultId
	,smFaultDetail.FlatRateId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFaultDetail_FaultId] TO [MSDSL]
    AS [dbo];

