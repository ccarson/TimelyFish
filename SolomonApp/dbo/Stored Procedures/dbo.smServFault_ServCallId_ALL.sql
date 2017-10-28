 CREATE PROCEDURE smServFault_ServCallId_ALL
	@parm1 varchar(10)
	,@parm2beg smallint
	,@parm2end smallint
AS
SELECT *
FROM smServFault
	left outer join smcode
		on smServFault.faultcodeid = smcode.Fault_Id
	left outer join smEmp
		on smServFault.EmpId = smEmp.EmployeeId
	left outer join smCause
		on smServFault.CauseID = smCause.CauseID
	left outer join smResolution
		on smServFault.ResolutionID = smResolution.REsolutionID
WHERE ServiceCallId = @parm1
	AND LineNbr BETWEEN @parm2beg AND @parm2end
ORDER BY ServiceCallId
	,LineNbr


