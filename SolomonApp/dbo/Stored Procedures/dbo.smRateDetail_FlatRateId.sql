 CREATE PROCEDURE smRateDetail_FlatRateId
	@parm1 varchar(10)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT *
FROM smRateDetail
	left outer join Inventory
		on smRateDetail.InvtId = Inventory.InvtId
WHERE FlatRateId = @parm1
	AND LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY FlatRateId
	,LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRateDetail_FlatRateId] TO [MSDSL]
    AS [dbo];

