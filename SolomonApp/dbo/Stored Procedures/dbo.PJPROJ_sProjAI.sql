 create procedure PJPROJ_sProjAI  @parm1 varchar (16)  as
select * from PJPROJ
where
project like @parm1 and
(status_pa = 'A' or  status_pa = 'I')
order by project

