 create procedure PJRULES_spk0 @parm1 varchar (4) , @parm2 varchar (16) as
select *
from PJRULES
	left outer join PJACCT
		on PJRULES.acct = PJACCT.acct
where bill_type_cd = @parm1
	and PJRULES.acct like @parm2
order by PJRULES.bill_type_cd, PJRULES.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRULES_spk0] TO [MSDSL]
    AS [dbo];

