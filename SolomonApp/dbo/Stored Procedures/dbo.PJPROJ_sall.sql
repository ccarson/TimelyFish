 create procedure PJPROJ_sall @parm1 varchar (16)  as
select * from PJPROJ
where project like @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sall] TO [MSDSL]
    AS [dbo];

