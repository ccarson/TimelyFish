 CREATE PROCEDURE
	smServFault_Lupd
		@parm1	varchar(10),
		@parm2	varchar(10),
		@parm3	varchar(10),
		@parm4	datetime
AS
	SELECT
		smEmp.EmployeeID, smEmp.EmployeeActive, smEmp.EmployeeType,
		smServFault.ServiceCallID, smServFault.FaultCodeID, smServFault.LineNbr,
		smServFault.LineID, smServFault.TaskStatus,
		smServFault.StartDate, smServFault.StartTime,
		smServFault.EndDate, smServFault.EndTime,
		smServFault.Duration,
		smServCall.CallerName, SOAddress.Addr1, SOAddress.Addr2,
		SOAddress.City, SOAddress.Zip, SOAddress.Phone,
		smServCall.CustGeographicID, smServCall.ServiceCallStatus
	FROM
		smEmp, smServFault, smServCall, SOAddress
	WHERE
		smServFault.EmpID = smEmp.EmployeeID
		AND smServFault.StartDate = @parm1
		AND smEmp.EmployeeActive > 0
		AND smEmp.EmployeeBranchID LIKE @parm2
		AND smEmp.EmployeeType LIKE @parm3
--		smServFault.Lupd_DateTime >= @parm4
		AND CONVERT(DATETIME,SF_ID03)  >= @parm4
		AND smServCall.ServiceCallID = smServFault.ServiceCallID
		AND SOAddress.CustID = smServCall.CustomerID
		AND SOAddress.ShipToID = smServCall.ShipToID
	ORDER BY
		smEmp.EmployeeId, smServFault.StartDate, smServFault.StartTime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServFault_Lupd] TO [MSDSL]
    AS [dbo];

