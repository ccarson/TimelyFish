 CREATE PROCEDURE
	smServFault_Filter
		@parm0  varchar(15),		-- Customer ID
		@parm1	varchar(10),		-- Emp ID
		@parm2	varchar(10),		-- Contract ID
		@parm3	varchar(10),		-- BranchID
		@parm4	varchar(10),		-- View ID (ConfigCode)
		@parm5  varchar(1)		-- Call priority
AS
	DECLARE @szSelect	varchar(500)
	DECLARE @szFrom		varchar(500)
	DECLARE @szWhere	varchar(500)
	DECLARE @szOrderBy	varchar(100)

	DECLARE @szWhereBranchID	varchar(50)
	DECLARE @szWhereCustID		varchar(50)
	DECLARE @szWhereEmpID		varchar(50)
	DECLARE @szWhereContractID	varchar(50)
	DECLARE @szWhereGeoZone		varchar(200)
	DECLARE @szPriority		varchar(50)

	-- initialize
	SELECT @szWhereBranchID = ''
	SELECT @szWhereCustID = ''
	SELECT @szWhereEmpID = ''
	SELECT @szWhereContractID = ''
	SELECT @szWhereGeoZone = ''
	SELECT @szPriority = ''

IF LEN(@parm3) > 0 AND @parm3 <> '%'	-- there is BranchID
BEGIN
	SELECT @szWhereBranchID = " AND smEmp.EmployeeBranchID = '" + @parm3 + "'"
END

IF Len(@parm0) > 0
BEGIN
	Select @szWhereCustID = " And smServCall.CustomerID = '" + @parm0 + "'"
END

IF Len(@parm1) > 0
BEGIN
	Select @szWhereEmpID = " And smServFault.EmpID = '" + @parm1 + "'"
END

IF Len(@parm2) > 0
BEGIN
-- If a wildcard was specified for the contract value, then only return those
--			calls with a contract.  Otherwise, look for a specific contract id.
	IF @parm2 <> '%'
	BEGIN
		Select @szWhereContractID = " And smServFault.ContractID = '" + @parm2 + "'"
	END	
	Else
	BEGIN
		Select @szWhereContractID = " And smServFault.ContractID <> ''"
	END
END


IF LEN(@parm4) > 0	-- there is View ID (ConfigCode), Geographic Zones filter
BEGIN
	SELECT @szWhereGeoZone = " AND EXISTS (SELECT GeographicID FROM smSCQGeo (NOLOCK)
						WHERE	ConfigCode = '" + @parm4 + "' AND
							GeographicID = smServCall.CustGeographicID)"
END

-- Support the selection of all priorities and for a blank priority.
IF LEN(@parm5) > 0 	
BEGIN
	if @parm5 = '%' 
	BEGIN
		Select @szPriority = " And smServCall.ServiceCallPriority LIKE '%'"
	END
	ELSE
	BEGIN
		Select @szPriority = " And smServCall.ServiceCallPriority = '" + @parm5 + "'"
	END
END
ELSE
BEGIN
	Select @szPriority = " And smServCall.ServiceCallPriority = ''"
END


	SELECT @szSelect = "SELECT
		smEmp.EmployeeID,smServFault.ServiceCallID,
		smServFault.FaultCodeID,smServFault.ContractID,
		smServFault.LineNbr,smServFault.LineID, 
		smServFault.TaskStatus,	smServFault.StartDate, 
		smServFault.StartTime,	smServFault.EndDate,
		smServFault.EndTime, smServCall.CustName, smServCall.CustomerID,
		smServCall.CustGeographicID, smServCall.ServiceCallStatus, smServCall.ServiceCallPriority"


-- Inner Loop Join causes bad queries when there are no BranchID
	SELECT @szFrom = CASE WHEN LEN(@parm3) > 0 AND @parm3 <> '%'
                              THEN " FROM smEmp (NOLOCK)
			          INNER LOOP JOIN smServFault (NOLOCK)
					  ON smServFault.EmpID = smEmp.EmployeeID
				  JOIN smServCall (NOLOCK)
					  ON smServCall.ServiceCallID = smServFault.ServiceCallID"
                              ELSE  " FROM smEmp (NOLOCK)
				  JOIN smServFault (NOLOCK)
				          ON smServFault.EmpID = smEmp.EmployeeID
				  JOIN smServCall (NOLOCK)
				  	  ON smServCall.ServiceCallID = smServFault.ServiceCallID"
                          END
	SELECT @szWhere = " WHERE
		smEmp.EmployeeActive > 0 "
		+ @szWhereBranchID
		+ @szWhereCustID
		+ @szWhereEmpID
		+ @szWhereContractID
		+ @szPriority
		+ " AND ServiceCallCompleted = 0
		AND smServCall.ServiceCallStatus = 'R'"
		+ @szWhereGeoZone

	SELECT @szOrderBy = " ORDER BY smServFault.StartDate, smServFault.ServiceCallID, smServFault.FaultCodeID"
 
--PRINT (@szSelect + @szFrom + @szWhere + @szOrderBy)

	-- execute statement
	EXEC (@szSelect + @szFrom + @szWhere + @szOrderBy)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[smServFault_Filter] TO [MSDSL]
    AS [dbo];

