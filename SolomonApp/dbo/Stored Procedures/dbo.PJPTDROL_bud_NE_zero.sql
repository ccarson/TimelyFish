 create procedure PJPTDROL_bud_NE_zero @parm1 varchar (16) as
	select *
	from 	pjptdrol
	where	project =  @parm1
	and	(PJPTDROL.eac_amount <> 0 Or PJPTDROL.eac_units <> 0 Or
		 PJPTDROL.fac_amount <> 0 Or PJPTDROL.fac_units <> 0 Or
		 PJPTDROL.total_budget_amount <> 0 Or PJPTDROL.total_budget_units <> 0)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_bud_NE_zero] TO [MSDSL]
    AS [dbo];

