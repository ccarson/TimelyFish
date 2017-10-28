 create procedure  PJBHSSUM_sSumA  @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (2) , @parm4 varchar (1) , @parm5 varchar (6)   as
select sum (total_budget_amount), sum (total_budget_units), sum (eac_amount), sum (eac_units), sum (fac_amount), sum (fac_units),
sum (ProjCury_tot_bud_amt), sum (ProjCury_eac_amount), sum (ProjCury_fac_amount)
from pjbhssum, pjacct
where pjbhssum.project = @parm1 and
pjbhssum.pjt_entity =  @parm2 and
pjbhssum.fiscalno <= @parm5 and
pjbhssum.acct =  pjacct.acct  and
pjacct.acct_type like @parm3 and
pjacct.id3_sw like @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBHSSUM_sSumA] TO [MSDSL]
    AS [dbo];

