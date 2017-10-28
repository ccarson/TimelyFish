 create procedure PJPTDSUM_sPK6 @parm1 varchar (16) as
select PJPTDSUM.*,PJACCT.*,PJPENT.*
from PJPTDSUM
	left outer join PJPENT
		on 	pjptdsum.project = pjpent.project
		and pjptdsum.pjt_entity = pjpent.pjt_entity
	, PJACCT
where
	pjptdsum.project = @parm1 and
	pjptdsum.acct = pjacct.acct AND
	(pjacct.acct_type = 'EX' or pjacct.acct_type = 'RV')
order by pjptdsum.pjt_entity,pjacct.sort_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_sPK6] TO [MSDSL]
    AS [dbo];

