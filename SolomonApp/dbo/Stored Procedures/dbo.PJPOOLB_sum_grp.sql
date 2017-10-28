 Create Proc PJPOOLB_sum_grp @parm1 varchar (6), @parm2 varchar (10), @parm3 varchar(6) as
select
 sum(alloc_amount_ptd),
 sum(alloc_amount_ytd),
 sum(basis_amount_ptd),
 sum(basis_amount_ytd),
 grpid
from
 PJPOOLB
where
 period = @parm1 and
 alloc_cpnyid = @parm2 and
 grpid = @parm3
group by
 grpid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLB_sum_grp] TO [MSDSL]
    AS [dbo];

