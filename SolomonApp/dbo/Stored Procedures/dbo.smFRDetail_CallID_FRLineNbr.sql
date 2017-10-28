 CREATE PROCEDURE smFRDetail_CallID_FRLineNbr
	@parm1 varchar(10)
	,@parm2 smallint
	,@parm3beg smallint
	,@parm3end smallint
AS
SELECT *
FROM smFRDetail
	left outer join Inventory
		on smFRDetail.InvtID = Inventory.InvtId
WHERE ServiceCallID = @parm1
	AND FlatRateLineNbr = @parm2
	AND LineNbr BETWEEN @parm3beg AND @parm3end
ORDER BY ServiceCallID
	,FlatRateLineNbr ,LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smFRDetail_CallID_FRLineNbr] TO [MSDSL]
    AS [dbo];

