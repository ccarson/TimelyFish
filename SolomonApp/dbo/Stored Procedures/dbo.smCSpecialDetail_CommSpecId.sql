 CREATE PROCEDURE smCSpecialDetail_CommSpecId
	@parm1 varchar(24)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT *
FROM smCSpecialDetail
	left outer join Inventory
		on smCSpecialDetail.InvtID = Inventory.InvtId
WHERE CommSpecId = @parm1
	AND LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY CommSpecId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCSpecialDetail_CommSpecId] TO [MSDSL]
    AS [dbo];

