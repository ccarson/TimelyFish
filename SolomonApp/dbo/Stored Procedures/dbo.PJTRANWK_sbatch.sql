 create procedure PJTRANWK_sbatch @parm1 varchar (6), @parm2 varchar (2) , @parm3 varchar (10) as
select distinct batch_id, batch_type
from PJTRANWK
where fiscalno = @parm1 and
system_cd = @parm2 and
batch_id like @parm3
order by batch_id


