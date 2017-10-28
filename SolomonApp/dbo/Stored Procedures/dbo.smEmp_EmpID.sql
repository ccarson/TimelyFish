 CREATE PROCEDURE
	smEmp_EmpID
		@parm1	varchar(10),		-- Branch
		@parm2	varchar(10),		-- Emp Type
		@parm3	varchar(10),		-- View ID (ConfigCode)
		@parm4	varchar(10)		-- Order By

AS
	DECLARE @szSelect	varchar(100)
	DECLARE @szWhere	varchar(3000)
	DECLARE @szOrderBy	varchar(100)

	DECLARE @szWhereBranchID	varchar(100)
	DECLARE @szWhereGeoZone		varchar(300)

	-- initialize
	SELECT @szWhereBranchID = ''
	SELECT @szWhereGeoZone = ''

IF LEN(@parm1) > 0 AND @parm1 <> '%'	-- there is BranchID
BEGIN
	SELECT @szWhereBranchID = " AND smEmp.EmployeeBranchID = '" + @parm1 + "'"
END
IF LEN(@parm3) > 0	-- there is View ID (ConfigCode), Geographic Zones filter
BEGIN
	SELECT @szWhereGeoZone = " AND EXISTS (SELECT smEmpArea.EmployeeID
					FROM smEmpArea, smSCQGeo
					WHERE smSCQGeo.ConfigCode = '" + @parm3 + "' AND
					      smEmpArea.AreaID = smSCQGeo.GeographicID AND
					      smEmpArea.EmployeeID = smEmp.EmployeeID )"
END

	-- Zones filter is blank
	IF LEN(@parm3) = 0
	BEGIN
		SELECT @szSelect = "SELECT
			smEmp.EmployeeId, smEmp.EmployeeActive, smEmp.EmployeeType
			FROM smEmp"

		SELECT @szWhere = " WHERE
			smEmp.EmployeeActive > 0 "
--			smEmp.EmployeeBranchID LIKE '" + @parm1 + "' AND
			+ @szWhereBranchID
			+ " AND smEmp.EmployeeType LIKE '" + @parm2 + "'"
	END
	ELSE
	BEGIN
		-- there is exists filter for Geographic Zones
		SELECT @szSelect = "SELECT
			smEmp.EmployeeId, smEmp.EmployeeActive, smEmp.EmployeeType
			FROM smEmp"
		SELECT @szWhere = " WHERE
			smEmp.EmployeeActive > 0 "
--			AND smEmp.EmployeeBranchID LIKE '" + @parm1 + "'
			+ @szWhereBranchID
			+ " AND smEmp.EmployeeType LIKE '" + @parm2 + "'"
--			AND smEmp.EmployeeID = smEmpArea.EmployeeID
--			AND smEmpArea.AreaID IN (" + @parm3 + ")"
			+ @szWhereGeoZone
	END

	IF @parm4 = 0
	BEGIN				-- order by Employee Type
		SELECT @szOrderBy = " ORDER BY smEmp.EmployeeType, smEmp.EmployeeId"
	END
	ELSE BEGIN			-- order by Employee ID
		SELECT @szOrderBy = ""
	END

--PRINT (@szSelect + @szWhere + @szOrderBy)

	-- execute statement
	EXEC (@szSelect + @szWhere + @szOrderBy)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEmp_EmpID] TO [MSDSL]
    AS [dbo];

