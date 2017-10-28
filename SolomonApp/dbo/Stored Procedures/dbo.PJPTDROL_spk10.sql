 create procedure PJPTDROL_spk10 @parm1 varchar (16) as
select pjacct.ca_id20,pjacct.acct_desc,pjacct.acct,pjacct.id1_sw,
	PJPTDROL.act_amount,PJPTDROL.eac_amount,PJPTDROL.act_units,PJPTDROL.eac_units
from pjacct
	left outer join PJPTDROL
		on pjacct.acct = PJPTDROL.acct
where project = @parm1 and pjacct.ca_id20 = 'W'
order by pjacct.sort_num, pjacct.acct

select pjacct.ca_id20,pjacct.acct_desc,pjacct.acct,pjacct.id1_sw,
	PJPTDROL.act_amount,PJPTDROL.eac_amount,PJPTDROL.act_units,PJPTDROL.eac_units
from pjacct
	left outer join PJPTDROL
		on pjacct.acct = PJPTDROL.acct
where project = @parm1 and pjacct.ca_id20 = 'E'
order by pjacct.sort_num, pjacct.acct

select pjacct.ca_id20,pjacct.acct_desc,pjacct.acct,pjacct.id1_sw,
	PJPTDROL.act_amount,PJPTDROL.eac_amount,PJPTDROL.act_units,PJPTDROL.eac_units
from pjacct
	left outer join PJPTDROL
		on pjacct.acct = PJPTDROL.acct
where project = @parm1 and pjacct.ca_id20 = 'R'
order by pjacct.sort_num, pjacct.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_spk10] TO [MSDSL]
    AS [dbo];

