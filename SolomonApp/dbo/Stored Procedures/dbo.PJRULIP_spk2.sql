 create procedure PJRULIP_spk2 @parm1 varchar (16) ,@parm2 varchar (16) as
select *
from PJBILL, PJRULIP
	left outer join PJACCT
		on 	pjrulip.acct = pjacct.acct
where pjbill.project = @parm1 and
	pjrulip.bill_type_cd = pjbill.bill_type_cd and
	PJRULIP.acct = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRULIP_spk2] TO [MSDSL]
    AS [dbo];

