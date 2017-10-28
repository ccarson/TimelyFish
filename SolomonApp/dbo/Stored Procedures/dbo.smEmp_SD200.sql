 CREATE PROCEDURE
	smEmp_SD200
		@parm1	varchar(10),		-- Branch
		@parm2	varchar(10),		-- Emp Type
		@parm3	varchar(10),		-- Geographic ID
		@parm4	varchar(1),		-- Order By
		@parm5	varchar(40),		-- Employees ID to be filter
		@parm6	varchar(1) 		-- 1: included or 0: excluded employees
AS
	DECLARE @szSelect	varchar(100)
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

IF LEN(@parm1) > 0 AND @parm1 <> '%'	-- there is BranchID filter
BEGIN
	SELECT @szWhereBranchID = " AND smEmp.EmployeeBranchID = '" + @parm1 + "'"
END
IF LEN(@parm2) > 0 AND @parm2 <> '%'	-- there is Emp Type filter
BEGIN
	SELECT @szWhereEmpType = " AND smEmp.EmployeeType = '" + @parm2 + "'"
END
IF LEN(@parm3) > 0 AND @parm3 <> '%'	-- there is Geographic ID filter
BEGIN
	SELECT @szWhereGeoZone = " AND EXISTS (SELECT smEmpArea.EmployeeID
					FROM smEmpArea (NOLOCK)
					WHERE smEmpArea.AreaID = '" + @parm3 + "' AND
					      smEmpArea.EmployeeID = smEmp.EmployeeID )"
END
IF @parm4 = '0'
BEGIN				-- order by Employee Type
	SELECT @szOrderBy = " ORDER BY smEmp.EmployeeType, smEmp.EmployeeID"
END
ELSE BEGIN			-- order by Employee ID
	SELECT @szOrderBy = " ORDER BY smEmp.EmployeeID"
END
IF LEN(@parm5) > 0 	-- Employees ID filter
BEGIN
	IF @parm6 = '1'
	BEGIN
		SELECT @szWhereEmpID = " AND smEmp.EmployeeID IN " + @parm5
	END
	ELSE BEGIN
		SELECT @szWhereEmpID = " AND smEmp.EmployeeID NOT IN " + @parm5
	END
END

	SELECT @szSelect = "SELECT
		smEmp.EmployeeID, smEmp.EmployeeActive, smEmp.EmployeeType
		FROM smEmp (NOLOCK)"

	SELECT @szWhere = " WHERE
		smEmp.EmployeeActive > 0 "
		+ @szWhereBranchID
		+ @szWhereEmpType
		+ @szWhereGeoZone
		+ @szWhereEmpID

-- PRINT @szSelect + @szWhere + @szOrderBy

	-- execute statement
	EXEC (@szSelect + @szWhere + @szOrderBy)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmp_SD200] TO [MSDSL]
    AS [dbo];

