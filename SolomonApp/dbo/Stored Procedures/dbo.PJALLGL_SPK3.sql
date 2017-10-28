 create procedure PJALLGL_SPK3  @parm1 varchar (10), @parm2 varchar (16)  as
select   sum(amount), cpnyid, gl_acct, gl_subacct, sum(units)
from    PJALLGL
where alloc_batch = @parm1 and
      source_project = @parm2
group by cpnyid, gl_acct, gl_subacct
order by cpnyid, gl_acct, gl_subacct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLGL_SPK3] TO [MSDSL]
    AS [dbo];

