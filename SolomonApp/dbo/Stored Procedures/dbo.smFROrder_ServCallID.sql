 CREATE PROCEDURE smFROrder_ServCallID
	@parm1 varchar(10)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT *
FROM smFROrder
	left outer join smFlatRate
		on smFROrder.FlatRateID = smFlatRate.FlatRateId
	,smPlan
WHERE ServCallID = @parm1
	AND smFROrder.PlanID = smPlan.PlanID
	AND LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY ServCallID, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFROrder_ServCallID] TO [MSDSL]
    AS [dbo];

