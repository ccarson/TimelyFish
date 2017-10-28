 create procedure PJPROJ_savailemp_ne @parm1 varchar (16)  as
select * from PJPROJ
where project    like @parm1
and status_pa  IN   ('A','I','M')
and status_19 = '1' --Available All Employee is unchecked
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_savailemp_ne] TO [MSDSL]
    AS [dbo];

