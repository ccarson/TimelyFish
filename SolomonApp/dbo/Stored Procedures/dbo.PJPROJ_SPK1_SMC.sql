 create procedure PJPROJ_SPK1_SMC @parm1 varchar(100), @parm2 varchar (16)  as
select * from PJPROJ
where  CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm1))
and project    like @parm1
and status_pa  =    'A'
order by project

