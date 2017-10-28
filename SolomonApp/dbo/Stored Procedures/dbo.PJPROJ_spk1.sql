 create procedure PJPROJ_spk1 @parm1 varchar (16)  as
select * from PJPROJ
where project    like @parm1
and status_pa  =    'A'
order by project

