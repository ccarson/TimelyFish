 create procedure PJPROJ_SSUBCON_MC @parm1 varchar(100), @parm2 varchar (16)  as
select distinct PJPROJ.* from PJPROJ, PJSUBCON
where PJPROJ.project like @parm2 and
PJPROJ.project = PJSUBCON.project
order by PJPROJ.project

