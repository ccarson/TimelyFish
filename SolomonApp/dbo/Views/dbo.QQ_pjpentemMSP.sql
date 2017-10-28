
CREATE VIEW [QQ_pjpentemMSP]
AS
SELECT	E.Project AS [project in PJPENTEM], E.Pjt_entity AS [task in PJPENTEM], P.pjt_entity_desc AS [task description], E.Employee AS [employee in PJPENTEM], E.SubTask_Name AS [subtask in PJPENTEM], 
		X.Project AS [project in XREF], X.Pjt_Entity AS [task in XREF], X.Employee AS [employee in XREF], X.SubTask_Name AS [subtask in XREF], 
		X.Assignment_MSPID AS [MSP internal assignment GUid], P.MSPInterface AS [MSP task interface flag], P.status_pa AS [task status], 
		CONVERT(DATE,E.lupd_datetime) AS [last update date in PJPENTEM], E.lupd_prog AS [last update program in PJPENTEM], 
		E.lupd_user AS [last update user in PJPENTEM], CONVERT(DATE,X.LUpd_DateTime) AS [last update date in XREF], X.LUpd_Prog AS [last update program in XREF], 
		X.LUpd_User AS [last update user in XREF]

FROM	PJPENTEM E WITH (nolock) 
			INNER JOIN PJPENT P WITH (nolock) ON E.Pjt_entity = P.pjt_entity AND E.Project = P.project 
			FULL OUTER JOIN PJPENTEMXREFMSP X WITH (nolock) ON E.Employee = X.Employee AND E.Project = X.Project AND E.Pjt_entity = X.Pjt_Entity

WHERE	(P.MSPInterface = 'Y') 
			AND (X.Assignment_MSPID IS NULL 
		OR X.Assignment_MSPID = ' ') 
		OR (X.Assignment_MSPID IS NOT NULL) 
			AND (E.Project IS NULL)

