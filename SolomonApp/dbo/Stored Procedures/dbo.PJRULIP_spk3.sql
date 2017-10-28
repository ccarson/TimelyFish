 create procedure PJRULIP_spk3 @parm1 varchar (16) ,@parm2 varchar (16) as
select *
from PJRULIP
	left outer join PJACCT
		on pjrulip.acct = pjacct.acct
	,PJBILL
where pjrulip.bill_type_cd = pjbill.bill_type_cd and
	pjbill.project = @parm1 and
	PJRULIP.acct = @parm2
order by pjrulip.bill_type_cd, pjrulip.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRULIP_spk3] TO [MSDSL]
    AS [dbo];

