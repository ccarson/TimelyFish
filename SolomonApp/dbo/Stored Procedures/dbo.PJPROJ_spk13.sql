 create procedure PJPROJ_spk13 @parm1 varchar (16)  as
select * from PJPROJ
where project    like @parm1
and (status_pa  =    'A' or status_pa = 'M')
order by project

