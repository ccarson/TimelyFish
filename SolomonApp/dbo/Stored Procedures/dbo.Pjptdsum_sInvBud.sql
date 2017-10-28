
create procedure Pjptdsum_sInvBud @parm1 varchar (16) , @parm2 varchar (4)   as
select distinct PJPTDSUM.project, PJPTDSUM.pjt_entity, PJPTDSUM.acct, PJPTDSUM.lupd_datetime, PJPTDSUM.total_budget_amount 
  from PJPTDSUM inner join PJINVSEC on PJPTDSUM.acct  = pjinvsec.acct 
where PJPTDSUM.project =  @parm1  and
pjinvsec.inv_format_cd  = @parm2
order by PJPTDSUM.project,
PJPTDSUM.pjt_entity,
PJPTDSUM.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Pjptdsum_sInvBud] TO [MSDSL]
    AS [dbo];

