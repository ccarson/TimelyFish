 create procedure PJprojex_sEQUAL @parm1 varchar (16)  as
select * from PJprojex
where project = @parm1
order by project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJprojex_sEQUAL] TO [MSDSL]
    AS [dbo];

