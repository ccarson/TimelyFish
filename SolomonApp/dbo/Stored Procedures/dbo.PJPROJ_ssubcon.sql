 create procedure PJPROJ_ssubcon @parm1 varchar (16)  as
select distinct PJPROJ.* from PJPROJ, PJSUBCON
where PJPROJ.project like @parm1 and
PJPROJ.project = PJSUBCON.project
order by PJPROJ.project

