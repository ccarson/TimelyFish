 

CREATE VIEW PJvPurge
AS 
SELECT PJPROJ.Project,
'Master' = case when PJBILL.Project = PJBILL.Project_BillWith then 'Y'
			else 'N' end
FROM PJPROJ left outer join PJBILL on PJPROJ.Project = PJBILL.Project 
WHERE
PJPROJ.Status_PA = 'P'

 
