 create procedure PJPROJ_spk10  @parm1 varchar (16)  as
-- This proceudre is used by IN Customizations
select project, project_desc, status_pa, status_in from PJPROJ
where
status_pa = 'A' and
status_in = 'A' and
project like @parm1
order by project

