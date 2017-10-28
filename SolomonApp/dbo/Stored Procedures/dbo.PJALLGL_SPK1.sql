 create procedure PJALLGL_SPK1 @parm1 varchar (10), @parm2 varchar (16)  as
select   sum(amount), cpnyid, gl_acct, gl_subacct, sum(units),
source_project, source_pjt_entity,  project, pjt_entity
from    PJALLGL
where alloc_batch = @parm1 and
      source_project = @parm2
group by source_project, source_pjt_entity, project, pjt_entity, cpnyid, gl_acct, gl_subacct
order by source_project, source_pjt_entity, project, pjt_entity, cpnyid, gl_acct, gl_subacct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLGL_SPK1] TO [MSDSL]
    AS [dbo];

