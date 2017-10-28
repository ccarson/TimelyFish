 create procedure PJPROJMX_scount @parm1 varchar (16) as
select count(*) from PJPROJMX where project like @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJMX_scount] TO [MSDSL]
    AS [dbo];

