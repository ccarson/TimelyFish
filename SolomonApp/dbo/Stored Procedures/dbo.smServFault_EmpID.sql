 CREATE PROCEDURE
	smServFault_EmpID
		@parm1	varchar(10),		-- Start Date
		@parm2	varchar(10),		-- End Date
		@parm3	varchar(10),		-- BranchID
		@parm4	varchar(10),		-- Employee Type
		@parm5	varchar(1),		-- order by parameter: 0 - Employee Type, 1 - Employee ID
		@parm6	varchar(10)		-- View ID (ConfigCode)
AS
	DECLARE @szSelect	varchar(600)
	DECLARE @szFrom		varchar(500)
	DECLARE @szWhere	varchar(500)
	DECLARE @szOrderBy	varchar(100)

	DECLARE @szWhereBranchID	varchar(50)
	DECLARE @szWhereEmpType		varchar(50)
	DECLARE @szWhereGeoZone		varchar(200)

	-- initialize
	SELECT @szWhereBranchID = ''
	SELECT @szWhereEmpType = ''
	SELECT @szWhereGeoZone = ''

IF LEN(@parm3) > 0 AND @parm3 <> '%'	-- there is BranchID
BEGIN
	SELECT @szWhereBranchID = " AND e.EmployeeBranchID = '" + @parm3 + "'"
END
IF LEN(@parm4) > 0 AND @parm4 <> '%'	-- there is an Employee Type
BEGIN
	SELECT @szWhereEmpType = " AND e.EmployeeType = '" + @parm4 + "'"
END
IF LEN(@parm6) > 0	-- there is View ID (ConfigCode), Geographic Zones filter
BEGIN
	SELECT @szWhereGeoZone = " AND EXISTS (SELECT GeographicID FROM smSCQGeo (NOLOCK)
						WHERE	ConfigCode = '" + @parm6 + "' AND
							GeographicID = smServCall.CustGeographicID)"
END

	SELECT @szSelect = "SELECT
		e.EmployeeID, e.EmployeeActive, e.EmployeeType,
		smServFault.ServiceCallID, smServFault.FaultCodeID, smServFault.LineNbr,
		smServFault.LineID, smServFault.TaskStatus,
		smServFault.StartDate, smServFault.StartTime,
		smServFault.EndDate, smServFault.EndTime,
		smServFault.Duration,
		smServCall.CallerName, smServCall.CustName, SOAddress.Addr1, SOAddress.Addr2,
		SOAddress.City, SOAddress.Zip, SOAddress.Phone,
		smServCall.CustGeographicID, smServCall.ServiceCallStatus, smServCall.CpnyID"

-- Inner Loop Join causes bad quieries when there are no BranchID
	SELECT @szFrom = CASE WHEN LEN(@parm3) > 0 AND @parm3 <> '%'
                              THEN " FROM smEmp e (NOLOCK)
			          INNER LOOP JOIN smServFault (NOLOCK)
					  ON smServFault.EmpID = e.EmployeeID
				  JOIN smServCall (NOLOCK)
					  ON smServCall.ServiceCallID = smServFault.ServiceCallID
				  JOIN SOAddress (NOLOCK)
					  ON SOAddress.CustID = smServCall.CustomerID
					  AND SOAddress.ShipToID = smServCall.ShipToID"
                              ELSE  " FROM smEmp e (NOLOCK)
				  JOIN smServFault (NOLOCK)
				          ON smServFault.EmpID = e.EmployeeID
				  JOIN smServCall (NOLOCK)
				  	  ON smServCall.ServiceCallID = smServFault.ServiceCallID
				  JOIN SOAddress (NOLOCK)
					  ON SOAddress.CustID = smServCall.CustomerID
					  AND SOAddress.ShipToID = smServCall.ShipToID"
                          END
	SELECT @szWhere = " WHERE
		smServFault.StartDate <= '" + @parm2 + "'
		AND smServFault.EndDate >= '" + @parm1 + "'
		AND e.EmployeeActive > 0 "
		+ @szWhereBranchID
		+ @szWhereEmpType
		+ " AND ServiceCallCompleted = 0
		AND smServCall.ServiceCallStatus = 'R'"
		+ @szWhereGeoZone

	IF @parm5 = 0
	BEGIN				-- order by Employee Type
		SELECT @szOrderBy = " ORDER BY e.EmployeeType, e.EmployeeID, smServFault.StartDate, smServFault.StartTime"
	END
	ELSE BEGIN			-- order by Employee ID
		SELECT @szOrderBy = " ORDER BY e.EmployeeID, smServFault.StartDate, smServFault.StartTime"
	END

--PRINT (@szSelect + @szFrom + @szWhere + @szOrderBy)

	-- execute statement
	EXEC (@szSelect + @szFrom + @szWhere + @szOrderBy)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServFault_EmpID] TO [MSDSL]
    AS [dbo];

