 create procedure PJALLGL_dbatch @parm1 varchar (10) as
delete from PJALLGL
where alloc_batch = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLGL_dbatch] TO [MSDSL]
    AS [dbo];

