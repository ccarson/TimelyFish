 create procedure PJPTDROL_spk1 @parm1 varchar (16)   as
select * from  PJPTDROL, PJACCT
where PJPTDROL.project =  @parm1 and
PJPTDROL.acct = PJACCT.acct
order by PJACCT.sort_num, PJACCT.acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_spk1] TO [MSDSL]
    AS [dbo];

