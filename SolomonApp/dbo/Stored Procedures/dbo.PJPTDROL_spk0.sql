 create procedure PJPTDROL_spk0 @parm1 varchar (16)   as
select * from  PJPTDROL, PJACCT
where PJPTDROL.project =  @parm1 and
PJPTDROL.acct = PJACCT.acct and
(PJACCT.acct_type = 'RV' or
	  PJACCT.acct_type = 'EX')
order by PJACCT.sort_num, PJACCT.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_spk0] TO [MSDSL]
    AS [dbo];

