 CREATE PROCEDURE smServUsage_ServCallId
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smServUsage
	left outer join smEqUsage
		on smServUsage.UsageID = smEqUsage.UsageID
WHERE ServiceCallId = @parm1
	AND smServUsage.UsageID LIKE @parm2
ORDER BY smServUsage.ServiceCallId
	,smServUsage.UsageID


