 create procedure PJPROJ_sallmet @parm1 varchar (16)  as
select * from PJPROJ
where project    like @parm1
and status_pa  IN   ('A','I')
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sallmet] TO [MSDSL]
    AS [dbo];

