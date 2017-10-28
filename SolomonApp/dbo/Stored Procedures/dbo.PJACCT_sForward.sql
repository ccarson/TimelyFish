 create procedure PJACCT_sForward @parm1 varchar (16)  as
select PJACCT.* from PJACCT, PJPTDROL
where
PJPTDROL.project = @parm1 and
(PJPTDROL.act_amount <> 0 or PJPTDROL.act_units <> 0 or PJPTDROL.ProjCury_act_amount <> 0) and
PJACCT.acct = PJPTDROL.acct and
(PJACCT.acct_type = 'AS' or PJACCT.acct_type = 'LB')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_sForward] TO [MSDSL]
    AS [dbo];

