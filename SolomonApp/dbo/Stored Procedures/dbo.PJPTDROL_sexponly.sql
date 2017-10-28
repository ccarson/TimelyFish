 create procedure PJPTDROL_sexponly @parm1 varchar (16)   as
select * from  PJPTDROL, PJACCT
where PJPTDROL.project =  @parm1 and
PJPTDROL.acct = PJACCT.acct and
PJACCT.acct_type = 'EX'
order by PJACCT.sort_num, PJACCT.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sexponly] TO [MSDSL]
    AS [dbo];

