 create procedure PJPROJ_spk9 @parm1 varchar (250) , @parm2 varchar (16)  as
select * from PJPROJ
where project = @parm2
order by project

