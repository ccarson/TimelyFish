 create procedure PJALLSRT_sbatch  @parm1 varchar (10)  as
select * from PJALLSRT
where alloc_batch = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLSRT_sbatch] TO [MSDSL]
    AS [dbo];

