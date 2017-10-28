
CREATE VIEW [QQ_pjprojMSP]
AS
SELECT	P.project AS [project in PJPROJ], P.project_desc AS [project description], X.Project AS [project in XREF], P.MSPInterface AS [interface flag], P.status_pa AS [project status], 
		X.Project_MSPID AS [MSP internal GUID], CONVERT(DATE,P.lupd_datetime) AS [last update date in PJPROJ], P.lupd_prog AS [last update program in PJPROJ], 
		P.lupd_user AS [last update user in PJPROJ], CONVERT(DATE,X.LUpd_DateTime) AS [last update date in XREF], X.LUpd_Prog AS [last update program in XREF], 
		X.LUpd_User AS [last update user in XREF]

FROM	PJPROJ P WITH (nolock) 
			FULL OUTER JOIN PJPROJXREFMSP X WITH (nolock) ON P.project = X.Project

WHERE	(P.MSPInterface = 'Y') 
			AND (X.Project_MSPID IS NULL 
		OR X.Project_MSPID = ' ') 
		OR (P.MSPInterface IS NULL) 
			AND (X.Project_MSPID IS NOT NULL) 
		OR (P.MSPInterface <> 'Y') 
			AND (X.Project_MSPID IS NOT NULL)

