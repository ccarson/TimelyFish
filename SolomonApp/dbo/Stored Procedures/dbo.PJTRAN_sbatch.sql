 create procedure PJTRAN_sbatch @parm1 varchar (6) , @parm2 varchar (2) , @parm3 varchar (10) as
select * from PJTRAN
where fiscalno       = @parm1  and
          system_cd  = @parm2  and
          batch_id      = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sbatch] TO [MSDSL]
    AS [dbo];

