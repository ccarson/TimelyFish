 Create Procedure pjptdrol_ssumra @parm1 varchar (16) as
select SUM ( pjptdrol.act_amount ),
SUM ( pjptdrol.act_units )
from pjptdrol, pjacct
where pjptdrol.project = @parm1 and
pjptdrol.acct =  pjacct.acct  and
(pjacct.acct_type = 'RV' or
pjacct.acct_type = 'AS')
group by pjptdrol.project
order by pjptdrol.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjptdrol_ssumra] TO [MSDSL]
    AS [dbo];

