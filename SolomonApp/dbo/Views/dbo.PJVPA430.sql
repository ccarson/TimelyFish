 

CREATE VIEW PJVPA430

AS 

 
select '1' as alloc_method_num, alloc_method_cd, project, project_desc, status_pa, cpnyid, customer from pjproj 
union
select '2' as alloc_method_num, alloc_method2_cd as alloc_method_cd, project, project_desc, status_pa, cpnyid, customer from pjproj 
where alloc_method2_cd <> ''

