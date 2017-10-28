CREATE VIEW [dbo].[QQProjectList]
AS
SELECT DISTINCT 
                         RTRIM(P.project) AS Project, RTRIM(P.project_desc) AS Description, 
                         CASE P.status_pa WHEN 'A' THEN 'Active' WHEN 'P' THEN 'Purge' WHEN 'D' THEN 'Delete' WHEN 'G' THEN 'Template' WHEN 'T' THEN 'Terminate' WHEN 'M'
                          THEN 'Plan' ELSE 'Inactive' END AS Status, P.CpnyId AS Company, dbo.NameFlip(PM.emp_name) AS ProjectManager, dbo.NameFlip(BM.emp_name) 
                         AS BusinessManager, dbo.NameFlip(EM.emp_name) AS Employee, P.customer, P.start_date AS StartDate, P.end_date AS EndDate, P.contract, 
                         RTRIM(P.gl_subacct) AS SubAccount, RTRIM(T.employee) AS EmployeeID, RTRIM(P.manager1) AS ProjMgrID, RTRIM(P.manager2) AS BusMgrID
FROM            dbo.PJPROJ AS P LEFT OUTER JOIN
                         dbo.PJPROJEM AS T ON P.project = T.project LEFT OUTER JOIN
                         dbo.PJPENT AS N ON N.project = P.project LEFT OUTER JOIN
                         dbo.PJEMPLOY AS PM ON P.manager1 = PM.employee LEFT OUTER JOIN
                         dbo.PJEMPLOY AS BM ON P.manager2 = BM.employee LEFT OUTER JOIN
                         dbo.PJEMPLOY AS EM ON T.employee = EM.employee
