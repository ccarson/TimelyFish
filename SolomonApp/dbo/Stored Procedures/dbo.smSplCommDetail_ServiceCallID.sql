 CREATE PROCEDURE smSplCommDetail_ServiceCallID
	@parm1 varchar(10)
	,@parm2 varchar(10)
AS
SELECT *
FROM smSplCommDetail
	left outer join smEmp
		on smSplCommDetail.EmpID = smEmp.EmployeeId
WHERE ServiceCallID = @parm1
	AND EmpID LIKE @parm2
ORDER BY ServiceCallID
	,EmpID


