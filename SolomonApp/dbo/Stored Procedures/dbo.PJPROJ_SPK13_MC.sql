 create procedure PJPROJ_SPK13_MC @parm1 varchar (100), @parm2 varchar (16)  as
select * from PJPROJ
where 
CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm1))   and
project    like @parm2
and (status_pa  =    'A' or status_pa = 'M')
order by project

