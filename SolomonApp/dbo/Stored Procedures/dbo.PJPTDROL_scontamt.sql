 create procedure PJPTDROL_scontamt @parm1 varchar (16) , @parm2 varchar (16)   as
	select
sum(r.eac_amount ), sum(r.total_budget_amount)
	from 	pjproj p, pjptdrol r
	where	p.contract =  @parm1
	     and	p.project = r.project
	     and	r.acct =  @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_scontamt] TO [MSDSL]
    AS [dbo];

