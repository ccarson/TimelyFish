
CREATE VIEW [QQ_pjemployMSP]
AS
SELECT	E.employee AS [resource ID], CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(E.EMP_NAME, 
		1, CHARINDEX('~', E.EMP_NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 60)))) 
		ELSE E.EMP_NAME END AS [resource name], E.emp_status AS status, X.Employee_MSPName AS [name in MSP], 
		X.Employee_MSPID AS [MSP internal GUID], X.Employee AS [resource ID in XREF], E.MSPInterface AS [interface flag], 
        E.MSPType AS [M=non-person], E.placeholder AS [Y=generic resource], X.ProjectManager AS [Y=project manager in MSP], 
		X.WindowsUserAcct AS [windows user account], CONVERT(DATE,E.lupd_datetime) AS [last update date in PJEMPLOY], 
		E.lupd_prog AS [last update program in PJEMPLOY], E.lupd_user AS [last update user in PJEMPLOY], 
		CONVERT(DATE,X.LUpd_DateTime) AS [last update date in XREF], X.LUpd_Prog AS [last update program in XREF], 
		X.LUpd_User AS [last update user in XREF], E.CpnyId

FROM	PJEMPLOY E WITH (nolock) 
		FULL OUTER JOIN PJEMPLOYXREFMSP X WITH (nolock) ON E.employee = X.Employee

WHERE	(E.MSPInterface = 'Y') 
			AND (X.Employee_MSPID IS NULL OR X.Employee_MSPID = ' ') 
		OR (E.MSPInterface IS NULL) 
			AND (X.Employee_MSPID IS NOT NULL) 
		OR (E.MSPInterface <> 'Y') 
			AND (X.Employee_MSPID IS NOT NULL)

