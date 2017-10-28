 CREATE PROCEDURE
	smServCall_TaskStatus
		@parm1	varchar(10),		-- TaskStatus
		@parm2	varchar(10),		-- Start Date
		@parm3	varchar(10),		-- End Date
		@parm4	varchar(10),		-- BranchID
		@parm5	varchar(22),		-- ServiceCallPriority
		@parm6	varchar(10)		-- View ID (ConfigCode)
AS
	DECLARE @szSQL			varchar(800)
	DECLARE @szFrom			varchar(500)
	DECLARE @szWhereBranchID	varchar(50)
	DECLARE @szWherePriority	varchar(62)
	DECLARE @szWhereGeoZone		varchar(50)

	-- initialize
	SELECT @szWhereBranchID = ''
	SELECT @szWherePriority = ''
	SELECT @szWhereGeoZone = ''
	
	

IF LEN(@parm4) > 0	-- there is BranchID
BEGIN
	SELECT @szWhereBranchID = ' AND BranchID = ' + QUOTENAME(@parm4,'''')
END
IF LEN(@parm5) > 0	-- there is ServiceCallPriority
BEGIN
	SELECT @szWherePriority = ' AND CHARINDEX(ServiceCallPriority,' + @parm5 + ') > 0'
END
IF LEN(@parm6) > 0	-- there is View ID (ConfigCode), Geographic Zones filter
BEGIN
--	SELECT @szWhereGeoZone = " AND EXISTS (Select GeographicID from smSCQGeo (NOLOCK)
--						Where	ConfigCode = '" + @parm6 + "' AND
--							GeographicID = smServCall.CustGeographicID)"
	SELECT @szFrom = ' FROM smSCQGeo (NOLOCK) INNER JOIN smServCall WITH (INDEX(smServCall_GDB2), NOLOCK)
				ON smSCQGeo.GeographicID = smServCall.CustGeographicID'
	SELECT @szWhereGeoZone = ' AND smSCQGeo.ConfigCode = ' + QUOTENAME(@parm6,'''')
END
ELSE BEGIN
	SELECT @szFrom = ' FROM smServCall WITH (INDEX(smServCall_GDB2), NOLOCK)'
END

	-- the rest of join tables
	SELECT @szFrom = @szFrom + ' LEFT OUTER JOIN smServFault (NOLOCK)
					ON smServFault.ServiceCallID = smServCall.ServiceCallID
					INNER LOOP JOIN SOAddress (NOLOCK)
					ON SOAddress.ShipToID = smServCall.ShipToID AND
					SOAddress.CustID = smServCall.CustomerID'

IF LEN(@parm1) > 0 		-- TaskStatus <> '', not 'Unassigned' value
BEGIN
--PRINT '1) Status = ' + @parm1 + '     BranchID = ' + @parm4 + '     Priority = ' + @parm5

	IF LTRIM(@parm1) = 'A'
	BEGIN
		-- QN 10/30/2000, TaskStatus = 'A' (Assigned) - filter by specify date
		SELECT @szSQL = 'SELECT DISTINCT smServCall.*, SOAddress.*' + @szFrom
				+ ' WHERE (smServFault.TaskStatus = ' + QUOTENAME(@parm1,'''') + ' )' 
				+ ' AND smServFault.StartDate <= ' + QUOTENAME(@parm3,'''')
				+ ' AND smServFault.EndDate >= ' + QUOTENAME(@parm2,'''')
				+ ' AND ServiceCallCompleted = 0
					AND smServCall.ServiceCallStatus+'''' = ''' + 'R' + ''''
				+ @szWhereBranchID
				+ @szWherePriority
				+ @szWhereGeoZone

--PRINT (@szSQL)

		-- execute statement
		EXEC (@szSQL)
	END
	ELSE
	BEGIN
		-- QN 02/07/2003, DE 231311 - User (1-4) TaskStatus
		IF CHARINDEX(@parm1, 'U1U2U3U4') > 0
		BEGIN
			SELECT @szSQL = 'SELECT DISTINCT smServCall.*, SOAddress.*' + @szFrom
					+ ' WHERE (smServFault.TaskStatus = ' + QUOTENAME(@parm1,'''') + ')'
					+ ' AND ServiceCallCompleted = 0
						AND smServCall.ServiceCallStatus+'''' = ''' + 'R' + ''''
					+ @szWhereBranchID
					+ @szWherePriority
					+ @szWhereGeoZone
	--PRINT (@szSQL)
				-- execute statement
			EXEC (@szSQL)
		END		-- QN 02/07/2003, User (1-4) TaskStatus
		ELSE
		BEGIN
			-- QN 10/30/2000, TaskStatus <> 'A' (not Unassigned and not Assigned) - not filter by specified date
			SELECT @szSQL = 'SELECT DISTINCT smServCall.*, SOAddress.*' + @szFrom
					+ ' WHERE (smServFault.TaskStatus = ' + QUOTENAME(@parm1,'''') + ')'
					+ ' AND ServiceCallCompleted = 0
						AND smServCall.ServiceCallStatus+'''' = ''' + 'R' + ''''
					+ @szWhereBranchID
					+ @szWherePriority
					+ @szWhereGeoZone
	--PRINT (@szSQL)
			-- execute statement
			EXEC (@szSQL)
		END
	END

END

ELSE BEGIN			-- TaskStatus = '', 'Unassigned'
--PRINT '2) Status = ' + @parm1 + '     BranchID = ' + @parm4 + '     Priority = ' + @parm5
	SELECT @szSQL = 'SELECT DISTINCT smServCall.*, SOAddress.*' + @szFrom
			+ ' WHERE (smServFault.TaskStatus = '''' OR smServFault.TaskStatus is NULL)
				AND ServiceCallCompleted = 0
				AND smServCall.ServiceCallStatus = ''R'''
			+ @szWhereBranchID
			+ @szWherePriority
			+ @szWhereGeoZone
--PRINT (@szSQL)

	-- execute statement
	EXEC (@szSQL)

END


