 Create Procedure pjptdrol_spk60 @parm1 varchar (16)  as
select SUM ( pjptdrol.eac_amount ),
SUM ( pjptdrol.eac_units )
from pjbill, pjptdrol, pjacct
where pjbill.project_billwith = @parm1 and
pjptdrol.project = pjbill.project and
pjacct.acct =  pjptdrol.acct  and
pjacct.acct_type = 'EX'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjptdrol_spk60] TO [MSDSL]
    AS [dbo];

