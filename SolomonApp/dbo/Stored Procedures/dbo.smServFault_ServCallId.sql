 CREATE PROCEDURE smServFault_ServCallId
	@parm1 varchar(10)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT *
FROM smServFault
	left outer join smcode
		on faultcodeid = smcode.Fault_Id
WHERE ServiceCallId = @parm1
	AND LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY ServiceCallId
	,LineNbr


