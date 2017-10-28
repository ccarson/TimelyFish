 Create Procedure PJPTDSUM_SSUMAFAC @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (2) , @parm4 varchar (1)  as
select SUM ( pjptdsum.act_amount ),
SUM ( pjptdsum.act_units ),
SUM ( pjptdsum.com_amount ),
SUM ( pjptdsum.com_units ),
SUM ( pjptdsum.eac_amount ),
SUM ( pjptdsum.eac_units ),
SUM ( pjptdsum.total_budget_amount ),
SUM ( pjptdsum.total_budget_units ),
SUM ( pjptdsum.fac_amount ),
SUM ( pjptdsum.fac_units ),
SUM ( pjptdsum.ProjCury_act_amount),
SUM ( pjptdsum.ProjCury_com_amount),
SUM ( pjptdsum.ProjCury_eac_amount),
SUM ( pjptdsum.ProjCury_tot_bud_amt),
SUM ( pjptdsum.ProjCury_fac_amount)
from pjptdsum, pjacct
where pjptdsum.project = @parm1 and
pjptdsum.pjt_entity =  @parm2 and
pjptdsum.acct =  pjacct.acct  and
pjacct.acct_type like @parm3 and
pjacct.id3_sw like @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_SSUMAFAC] TO [MSDSL]
    AS [dbo];

