 create procedure PJPTDROL_srevonly @parm1 varchar (16)   as
select * from  PJPTDROL, PJACCT
where PJPTDROL.project =  @parm1 and
PJPTDROL.acct = PJACCT.acct and
PJACCT.acct_type = 'RV'
order by PJACCT.sort_num, PJACCT.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_srevonly] TO [MSDSL]
    AS [dbo];

