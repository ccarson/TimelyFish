 Create Proc PJPOOLB_sum_spk2 @parm1 varchar (6), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (24) as
select
 sum(alloc_amount_ptd),
 sum(alloc_amount_ytd),
 sum(basis_amount_ptd),
 sum(basis_amount_ytd)
from
 PJPOOLB
where
 period = @parm1 and
 alloc_cpnyid = @parm2 and
 alloc_gl_acct = @parm3 and
 alloc_gl_subacct = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLB_sum_spk2] TO [MSDSL]
    AS [dbo];

