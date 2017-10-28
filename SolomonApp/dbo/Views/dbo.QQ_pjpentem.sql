
CREATE VIEW [QQ_pjpentem]
AS
SELECT     N.Project, P.project_desc AS [project description], N.Pjt_entity AS task, 
                      T.pjt_entity_desc AS [task descritpion], N.SubTask_Name AS subtask, N.Employee AS [resource number], 
                      CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', 
                      E.EMP_NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 60)))) 
                      ELSE E.EMP_NAME END AS [resource name], convert(date,N.Date_start) AS [start date], convert(date,N.Date_end) AS [end date], 
                      N.Budget_amt AS [estimated amount], N.Budget_units AS [estimated units], N.Actual_amt AS [actual amount], 
                      N.Actual_units AS [actual units], N.Revenue_amt AS [revenue amount], 
                      N.Revadj_amt AS [revenue adjustment amount], N.Comment, P.CpnyId AS [project company], 
                      E.manager1 AS supervisor, P.manager1 AS [project manager], T.manager1 AS [task manager], 
                      E.manager2 AS manager, P.manager2 AS [business manager], E.CpnyId AS [resource company], 
                      E.MSPType AS [non-person flag], E.Subcontractor AS [subcontractor flag], P.status_pa AS [project status], 
                      T.status_pa AS [task status], T.MSPInterface AS [MSP integrated flag], 
                      E.MSPInterface AS [resource MSP integrated flag], N.User1, N.User2, N.User3, 
                      N.User4, N.Tk_id01, N.Tk_id02, N.Tk_id03, N.Tk_id04, N.Tk_id05, 
                      N.Tk_id06, N.Tk_id07, convert(date,N.Tk_id08) AS [Tk_id08], convert(date,N.Tk_id09) AS [Tk_id09], N.Tk_id10, 
                      convert(date,N.crtd_datetime) AS [create date], N.crtd_prog AS [create program], N.crtd_user AS [create user], 
                      convert(date,N.lupd_datetime) AS [last update date], N.lupd_prog AS [last update program], 
                      N.lupd_user AS [last update user]
FROM         PJPENTEM N WITH (nolock) LEFT OUTER JOIN
                      PJEMPLOY E WITH (nolock) ON N.Employee = E.employee LEFT OUTER JOIN
                      PJPROJ P WITH (nolock) ON N.Project = P.project LEFT OUTER JOIN
                      PJPENT T WITH (nolock) ON N.Pjt_entity = T.pjt_entity AND N.Project = T.project

