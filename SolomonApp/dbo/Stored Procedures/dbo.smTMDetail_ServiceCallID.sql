 CREATE PROCEDURE smTMDetail_ServiceCallID
	@parm1 varchar(10)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT *
FROM smTMDetail
	left outer join Inventory
		on smTMDetail.InvtId = Inventory.InvtId
WHERE ServiceCallID = @parm1
	AND LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY ServiceCallID
	,LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smTMDetail_ServiceCallID] TO [MSDSL]
    AS [dbo];

