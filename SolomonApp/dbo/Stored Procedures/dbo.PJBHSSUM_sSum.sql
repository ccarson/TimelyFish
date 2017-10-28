 create procedure  PJBHSSUM_sSum  @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16) , @parm4 varchar (6)   as
select sum (total_budget_amount), sum (total_budget_units), sum (eac_amount), sum (eac_units), sum (fac_amount), sum (fac_units),
sum (ProjCury_tot_bud_amt), sum (ProjCury_eac_amount),  sum (ProjCury_fac_amount)
from pjbhssum
where project =  @parm1 and
pjt_entity  =  @parm2 and
acct = @parm3 and
fiscalno <= @parm4


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBHSSUM_sSum] TO [MSDSL]
    AS [dbo];

