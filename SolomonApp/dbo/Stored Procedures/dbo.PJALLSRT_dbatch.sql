 create procedure PJALLSRT_dbatch @parm1 varchar (10) as
delete from PJALLSRT
where alloc_batch = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLSRT_dbatch] TO [MSDSL]
    AS [dbo];

