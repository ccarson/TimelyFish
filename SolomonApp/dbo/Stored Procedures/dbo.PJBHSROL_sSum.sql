 create procedure  PJBHSROL_sSum  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (6)   as
select sum(total_budget_amount), sum (total_budget_units), sum (eac_amount), sum (eac_units), sum (fac_amount), sum (fac_units),
sum(ProjCury_tot_bud_amt), sum (ProjCury_eac_amount),  sum (ProjCury_fac_amount)
from pjbhsrol
where project =  @parm1 and
acct = @parm2 and
fiscalno <= @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBHSROL_sSum] TO [MSDSL]
    AS [dbo];

