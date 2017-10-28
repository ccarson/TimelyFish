 Create Procedure PJPTDROL_SSUMAFAC @parm1 varchar (16) , @parm2 varchar (2) , @parm3 varchar (1)  as
select SUM ( pjptdrol.act_amount ),
SUM ( pjptdrol.act_units ),
SUM ( pjptdrol.com_amount ),
SUM ( pjptdrol.com_units ),
SUM ( pjptdrol.eac_amount ),
SUM ( pjptdrol.eac_units ),
SUM ( pjptdrol.total_budget_amount ),
SUM ( pjptdrol.total_budget_units ),
SUM ( pjptdrol.fac_amount ),
SUM ( pjptdrol.fac_units ),
SUM ( pjptdrol.ProjCury_act_amount ),
SUM ( pjptdrol.ProjCury_com_amount ),
SUM ( pjptdrol.ProjCury_eac_amount ),
SUM ( pjptdrol.ProjCury_tot_bud_amt ),
SUM ( pjptdrol.ProjCury_fac_amount )
from pjptdrol, pjacct
where pjptdrol.project = @parm1 and
pjptdrol.acct =  pjacct.acct  and
pjacct.acct_type like @parm2 and
pjacct.id3_sw like @parm3


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_SSUMAFAC] TO [MSDSL]
    AS [dbo];

