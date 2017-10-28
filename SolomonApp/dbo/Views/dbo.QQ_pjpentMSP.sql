
CREATE VIEW [QQ_pjpentMSP]
AS
SELECT	E.project AS [project in PJPENT], P.project_desc AS [project description], E.pjt_entity AS [task in PJPENT], E.pjt_entity_desc AS [task description], 
		X.Project AS [project in XREF], X.Pjt_Entity AS [task in XREF], E.MSPInterface AS [MSP task interface flag], E.status_pa AS [task stastus], 
		P.status_pa AS [project status], P.MSPInterface AS [MSP project interface flag], X.Pjt_Entity_MSPID AS [MSP internal task GUID], 
		CONVERT(DATE,E.lupd_datetime) AS [last update date in PJPENT], E.lupd_prog AS [last update program in PJPENT], 
		E.lupd_user AS [last update user in PJPENT], CONVERT(DATE,X.LUpd_DateTime) AS [last update date in XREF], X.LUpd_Prog AS [last update program in XREF], 
		X.LUpd_User AS [last update user in XREF]
                      
FROM	PJPENT E WITH (nolock) 
			INNER JOIN PJPROJ P WITH (nolock) ON E.project = P.project 
			FULL OUTER JOIN PJPENTXREFMSP X WITH (nolock) ON E.pjt_entity = X.Pjt_Entity AND E.project = X.Project

WHERE	(E.MSPInterface = 'Y') 
			AND (X.Pjt_Entity_MSPID IS NULL 
		OR X.Pjt_Entity_MSPID = ' ') 
		OR (E.MSPInterface IS NULL) 
			AND (X.Pjt_Entity_MSPID IS NOT NULL) 
		OR (E.MSPInterface <> 'Y') 
			AND (X.Pjt_Entity_MSPID IS NOT NULL)

