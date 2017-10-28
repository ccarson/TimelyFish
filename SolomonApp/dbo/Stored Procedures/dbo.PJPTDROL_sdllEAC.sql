 create procedure PJPTDROL_sdllEAC @parm1 varchar (16) , @parm2 varchar (16)   as
select  pjbill.project_billwith,  pjptdrol.acct, sum(pjptdrol.eac_amount)
from    pjbill, pjptdrol
where   pjbill.project_billwith = @parm1
and        pjbill.project = pjptdrol.project
and        pjptdrol.acct = @parm2
group by        pjbill.project_billwith, pjptdrol.acct
order by        pjbill.project_billwith, pjptdrol.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sdllEAC] TO [MSDSL]
    AS [dbo];

