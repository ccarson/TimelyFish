 create procedure PJprojex_sALL @parm1 varchar (16)  as
select * from PJprojex
where project like @parm1
order by project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJprojex_sALL] TO [MSDSL]
    AS [dbo];

