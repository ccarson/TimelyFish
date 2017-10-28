
CREATE VIEW [QQ_pjprojem]
AS
SELECT     M.project, P.project_desc AS [project description], M.employee AS [resource id (*=avail to all)], 
                      CASE WHEN CHARINDEX('~', E.EMP_NAME) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(E.EMP_NAME, 1, CHARINDEX('~', 
                      E.EMP_NAME) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(E.EMP_NAME, CHARINDEX('~', E.EMP_NAME) + 1, 30)))) 
                      ELSE E.EMP_NAME END AS [resource name], P.manager1 AS [project manager], P.manager2 AS [business manager], 
                      P.customer, P.status_pa AS [project status], P.CpnyId AS [project company ID], 
                      P.gl_subacct AS [project subaccount], E.gl_subacct AS [resource home subaccount], 
                      E.emp_status AS [resource status], E.manager1 AS [resource supervisor], 
                      E.manager2 AS [resource manager], E.MSPType AS [M=non-person], E.Subcontractor AS [Y=subcontractor], 
                      E.placeholder AS [Y=generic resource], E.MSPInterface AS [resource MSP interface], 
                      P.MSPInterface AS [project MSP interface], M.noteId, M.pv_id01, M.pv_id02, M.pv_id03, 
                      M.pv_id04, M.pv_id05, M.pv_id06, M.pv_id07, convert(date,M.pv_id08) AS [pv_id08], 
                      convert(date,M.pv_id09) AS [pv_id09], M.pv_id10, M.user1, M.user2, M.user3, M.user4, 
                      convert(date,M.crtd_datetime) AS [create date], M.crtd_prog AS [create program], M.crtd_user AS [create user], 
                      convert(date,M.lupd_datetime) AS [last update date], M.lupd_prog AS [last update program], 
                      M.lupd_user AS [last update user]
FROM         PJPROJEM M WITH (nolock) LEFT OUTER JOIN
                      PJPROJ P WITH (nolock) ON M.project = P.project LEFT OUTER JOIN
                      PJEMPLOY E WITH (nolock) ON M.employee = E.employee

