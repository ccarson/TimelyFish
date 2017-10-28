 create procedure PJPROJ_sallstat @parm1 varchar (16)  as
select * from PJPROJ
where project    like @parm1
and status_pa  IN   ('A','I','M')
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sallstat] TO [MSDSL]
    AS [dbo];

