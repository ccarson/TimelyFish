 CREATE PROCEDURE smRateCommission_FlatRateId
	@parm1 varchar(10)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT *
FROM smRateCommission
	left outer join smCommType
		on smRateCommission.CommTypeId = smCommType.CommTypeId
WHERE flatRateId = @parm1
	AND LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY FlatRateId
	,LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRateCommission_FlatRateId] TO [MSDSL]
    AS [dbo];

