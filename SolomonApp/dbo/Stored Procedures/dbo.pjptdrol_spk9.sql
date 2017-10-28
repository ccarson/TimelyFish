 Create Procedure pjptdrol_spk9 @parm1 varchar (16) , @parm2 varchar (16)  as
select SUM ( pjptdrol.act_amount ),
SUM ( pjptdrol.act_units )
from pjbill, pjptdrol
where pjbill.project_billwith = @parm1 and
pjptdrol.project = pjbill.project and
pjptdrol.acct =  @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjptdrol_spk9] TO [MSDSL]
    AS [dbo];

