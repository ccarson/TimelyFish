
 CREATE PROCEDURE smServFault_SD200
		@parm1	varchar(10),		-- Start Date
		@parm2	varchar(10),		-- End Date
		@parm3	varchar(10),		-- BranchID
		@parm4	varchar(10),		-- Employee Type
		@parm5	varchar(1),		-- order by parameter: 1 - Employee Type, 0 - Employee ID
		@parm6	varchar(10),		-- Geographic ID
		@parm7	varchar(40),		-- Employees ID to be filter
		@parm8	varchar(1) 		-- 1: included or 0: excluded employees

AS
	DECLARE @szSelect	varchar(5000)
	DECLARE @szWhere	varchar(3000)
	DECLARE @szOrderBy	varchar(100)

	DECLARE @szWhereBranchID	varchar(100)
	DECLARE @szWhereEmpType 	varchar(100)
	DECLARE @szWhereGeoZone		varchar(200)
	DECLARE @szWhereEmpID		varchar(100)

	-- initialize
	SELECT @szWhereBranchID = ''
	SELECT @szWhereEmpType = ''
	SELECT @szWhereGeoZone = ''
	SELECT @szWhereEmpID = ''

IF LEN(@parm3) > 0 AND @parm3 <> '%'	-- there is BranchID filter
BEGIN
	SELECT @szWhereBranchID = " AND smEmp.EmployeeBranchID = '" + @parm3 + "'"
END
IF LEN(@parm4) > 0 AND @parm4 <> '%'	-- there is Emp Type filter
BEGIN
	SELECT @szWhereEmpType = " AND smEmp.EmployeeType = '" + @parm4 + "'"
END
IF @parm5 = 0
BEGIN				-- order by Employee Type
	SELECT @szOrderBy = " ORDER BY smEmp.EmployeeType, smEmp.EmployeeID, smServFault.StartDate, smServFault.StartTime"
END
ELSE BEGIN			-- order by Employee ID
	SELECT @szOrderBy = " ORDER BY smEmp.EmployeeID, smServFault.StartDate, smServFault.StartTime"
END
IF LEN(@parm6) > 0 AND @parm6 <> '%'	-- there is Geographic ID filter
BEGIN
	SELECT @szWhereGeoZone = " AND EXISTS (SELECT smEmpArea.EmployeeID
					FROM smEmpArea (NOLOCK)
					WHERE smEmpArea.AreaID = '" + @parm6 + "' AND
					      smEmpArea.EmployeeID = smEmp.EmployeeID )"
END
IF LEN(@parm7) > 0 	-- Employees ID filter
BEGIN
	IF @parm8 = '1'
	BEGIN
		SELECT @szWhereEmpID = " AND smEmp.EmployeeID IN " + @parm7
	END
	ELSE BEGIN
		SELECT @szWhereEmpID = " AND smEmp.EmployeeID NOT IN " + @parm7
	END
END

	SELECT @szSelect = "SELECT
		smEmp.EmployeeID, smServCall.CustName, smEmp.EmployeeActive, smEmp.EmployeeType,
		smServFault.ServiceCallID, smServFault.FaultCodeID, smServFault.LineNbr,
		smServFault.LineID, smServFault.TaskStatus,
		smServFault.StartDate, smServFault.StartTime,
		smServFault.EndDate, smServFault.EndTime,
		smServFault.Duration,
		smServCall.CallerName, SOAddress.Addr1, SOAddress.Addr2,
		SOAddress.City, SOAddress.Zip, SOAddress.Phone,
		smServCall.CustGeographicID, smServCall.ServiceCallStatus
	FROM
		smEmp (NOLOCK), smServFault (NOLOCK), smServCall (NOLOCK), SOAddress (NOLOCK)"
	SELECT @szWhere = "WHERE
		smServFault.EmpID = smEmp.EmployeeID
		AND NOT (smServFault.StartDate > '" + @parm2 + "' OR smServFault.EndDate < '" + @parm1 + "')
		AND smEmp.EmployeeActive > 0 "
		+ @szWhereBranchID
		+ @szWhereEmpType
		+ @szWhereGeoZone
		+ @szWhereEmpID
		+ " AND smServCall.ServiceCallID = smServFault.ServiceCallID
		AND ServiceCallCompleted = 0
		AND smServCall.ServiceCallStatus = '" + 'R' + "'
		AND SOAddress.CustID = smServCall.CustomerID
		AND SOAddress.ShipToID = smServCall.ShipToID "

--PRINT (@szSelect + @szWhere + @szOrderBy)

	-- execute statement
	EXEC (@szSelect + @szWhere + @szOrderBy)


