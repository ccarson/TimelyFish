CREATE PROCEDURE SyncQuickQueryViewRights AS

DECLARE csrRights CURSOR FOR
WITH
	dbpermissions AS (
	SELECT
	dprin.name AS user_name,
	dper.permission_name,
	so.name AS object_name
	FROM sys.database_permissions dper
	JOIN sys.database_principals dprin ON dper.grantee_principal_id = dprin.principal_id
	JOIN sys.objects so ON dper.major_id = so.object_id
	WHERE so.type = 'V' AND dprin.name NOT IN ('E8F575915A2E4897A517779C0DD7CE', 'MSDSL', '07718158D19D4f5f9D23B55DBF5DF1'))
,
	WindowsUserAccessRights AS (
	SELECT
	ur.WindowsUserAcct,
	s.Number AS ScreenNumber,
	s.ScreenType,
	MAX(adr.ViewRights) AS ViewRights,
	MAX(adr.UpdateRights) AS UpdateRights,
	MAX(adr.InsertRights) AS InsertRights,
	MAX(adr.DeleteRights) AS DeleteRights,
	MAX(adr.InitRights) AS InitRights
	FROM
	vs_accessdetrights adr
	JOIN vs_screen s ON adr.ScreenNumber = s.Number
	LEFT JOIN vs_usergrp ug ON adr.UserId = ug.GroupId AND adr.RecType = 'G'
	JOIN vs_userrec ur ON (adr.UserId = ur.UserId AND adr.RecType = 'U' AND ur.RecType = 'U') OR (ur.UserId = ug.UserId)
	WHERE adr.UserId != 'ADMINISTRATORS' AND adr.UserId != 'SYSADMIN' --administrators are assumed to always have full sql rights
	AND (adr.CompanyID IN (SELECT CpnyID FROM vs_company WHERE DatabaseName = DB_NAME()) OR adr.CompanyID = '[ALL]')
	GROUP BY
	ur.UserId, ur.WindowsUserAcct, s.Number, s.ScreenType)

SELECT wuar.WindowsUserAcct, qvc.SQLView, 1 AS Action
FROM WindowsUserAccessRights wuar
JOIN vs_qvcatalog qvc ON wuar.ScreenNumber = qvc.Number AND qvc.SystemDatabase = 0
LEFT JOIN dbpermissions dbp ON wuar.WindowsUserAcct = dbp.user_name AND qvc.SQLView = dbp.object_name
WHERE ScreenType = 'V' --Quick Query screens are 'V'
	--They do not have permissions and they should
	AND InitRights = 1 AND (permission_name IS NULL OR permission_name NOT LIKE '%SELECT%')
UNION
SELECT dbp.user_name AS WindowsUserAcct, qvc.SQLView, -1 AS Action
FROM dbpermissions dbp
JOIN vs_qvcatalog qvc ON qvc.SQLView = dbp.object_name AND qvc.SystemDatabase = 0
LEFT JOIN (SELECT DISTINCT WindowsUserAcct FROM vs_userrec) ur ON dbp.user_name = ur.WindowsUserAcct
LEFT JOIN WindowsUserAccessRights wuar ON wuar.WindowsUserAcct = ur.WindowsUserAcct AND wuar.ScreenNumber = qvc.Number AND wuar.ScreenType = 'V'
WHERE 
	--They have permissions and they should not
	dbp.permission_name LIKE '%SELECT%' AND (wuar.InitRights IS NULL OR wuar.InitRights = 0)

DECLARE @userAcct VARCHAR(50), @viewName VARCHAR(50), @action smallint

OPEN csrRights
FETCH NEXT FROM csrRights INTO @userAcct, @viewName, @action
WHILE (@@FETCH_STATUS = 0)
BEGIN
	DECLARE @sqlStmt varchar(255)

	IF @action = 1
		SET @sqlStmt = 'GRANT SELECT ON ' + RTRIM(@viewName) + ' TO [' + RTRIM(@userAcct) + ']'
	ELSE
		SET @sqlStmt = 'REVOKE SELECT ON ' + RTRIM(@viewName) + ' FROM [' + RTRIM(@userAcct) + ']'

	--PRINT @sqlStmt
	EXEC (@sqlStmt)

	FETCH NEXT FROM csrRights INTO @userAcct, @viewName, @action
END

CLOSE csrRights
DEALLOCATE csrRights

