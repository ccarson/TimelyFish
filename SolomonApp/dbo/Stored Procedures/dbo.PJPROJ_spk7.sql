 create procedure PJPROJ_spk7  @parm1 varchar (16)  as
select * From PJPROJ
where
status_pa = 'A' and
status_LB = 'A' and
project like @parm1
order by project

