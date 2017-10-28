CREATE VIEW [dbo].PJvProjectManager
AS
SELECT     dbo.PJPROJ.project, dbo.PJPROJ.manager1 AS PM01, dbo.PJEMPLOY.emp_name AS PM01_Name, 'PM1' as manager
FROM         dbo.PJPROJ INNER JOIN
                      dbo.PJEMPLOY ON dbo.PJPROJ.manager1 = dbo.PJEMPLOY.employee


