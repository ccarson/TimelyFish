 create procedure PJPROJ_SPK1_MC @parm1 varchar(10), @parm2 varchar(100), @parm3 varchar (16)  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
 as
select * from PJPROJ
where cpnyid like @parm1 and
cpnyid in (select cpnyid from dbo.UserAccessCpny(@parm2)) and
 project    like @parm3
and status_pa  =    'A'
order by project

