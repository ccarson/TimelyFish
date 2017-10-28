 create procedure PJPTDROL_spartprj @parm1 varchar (16), @parm2 varchar(100), @parm3 varchar(10)   as
select sum(eac_amount), sum(eac_units),
sum (total_budget_amount), sum(total_budget_units),
pjacct.acct, pjacct.acct_type, pjacct.sort_num,
sum(ProjCury_eac_amount), sum(ProjCury_tot_bud_amt)
from  PJPTDROL, PJACCT
where PJPTDROL.project like  @parm1 and 
PJPTDROL.acct = PJACCT.acct and
PJACCT.acct_type in ( 'RV', 'EX')
and Exists(
select project from PJPROJ
where pjproj.CpnyId in (select cpnyid from dbo.UserAccessCpny(@parm2)) and
pjproj.CpnyId like @parm3 and
pjproj.project = pjptdrol.project
)
group by pjacct.sort_num,
pjacct.acct,
pjacct.acct_type
order by PJACCT.sort_num, PJACCT.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_spartprj] TO [MSDSL]
    AS [dbo];

