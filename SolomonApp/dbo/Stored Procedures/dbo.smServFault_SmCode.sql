
 CREATE PROCEDURE smServFault_SmCode
	@parm1 varchar(10)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT smcode.*
FROM smcode, smservfault
	where smcode.Fault_ID = smservfault.faultcodeid
	and smservfault.ServiceCallId = @parm1
	AND smservfault.LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY smcode.Fault_Id

