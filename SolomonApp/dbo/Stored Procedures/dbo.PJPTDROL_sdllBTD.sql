 create procedure PJPTDROL_sdllBTD @parm1 varchar (16) , @parm2 varchar (16)   as
select  pjbill.project_billwith,  pjptdrol.acct, sum(pjptdrol.act_amount)
from    pjbill, pjptdrol
where   pjbill.project_billwith = @parm1
and        pjbill.project = pjptdrol.project
and        pjptdrol.acct = @parm2
group by        pjbill.project_billwith, pjptdrol.acct
order by        pjbill.project_billwith, pjptdrol.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sdllBTD] TO [MSDSL]
    AS [dbo];

