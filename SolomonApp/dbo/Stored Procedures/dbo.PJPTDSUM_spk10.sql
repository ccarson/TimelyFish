 create procedure PJPTDSUM_spk10 @parm1 varchar (16) , @parm2 varchar (32) as
select pjacct.ca_id20,pjacct.acct_desc,pjacct.acct,
	pjacct.id1_sw,pjptdsum.act_amount,pjptdsum.eac_amount,
	pjptdsum.act_units,pjptdsum.eac_units
from pjacct
	left outer join pjptdsum 
		on pjacct.acct = pjptdsum.acct
where project = @parm1 and pjt_entity = @parm2
	and pjacct.ca_id20 = 'W'
order by pjacct.sort_num, pjacct.acct
select pjacct.ca_id20,pjacct.acct_desc,pjacct.acct,pjacct.id1_sw,
	pjptdsum.act_amount,pjptdsum.eac_amount,pjptdsum.act_units,pjptdsum.eac_units
from pjacct
	left outer join pjptdsum
		on pjacct.acct = pjptdsum.acct
where project = @parm1 and pjt_entity = @parm2
	and pjacct.ca_id20 = 'E'
order by pjacct.sort_num, pjacct.acct
select pjacct.ca_id20,pjacct.acct_desc,pjacct.acct,pjacct.id1_sw,
	pjptdsum.act_amount,pjptdsum.eac_amount,pjptdsum.act_units,pjptdsum.eac_units
from pjacct
	left outer join pjptdsum
		on pjacct.acct = pjptdsum.acct
where project = @parm1 and pjt_entity = @parm2
	and pjacct.ca_id20 = 'R'
order by pjacct.sort_num, pjacct.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_spk10] TO [MSDSL]
    AS [dbo];

