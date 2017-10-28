 create procedure PJPTDSUM_spk0 @parm1 varchar (16)   as
select * from PJPTDSUM, PJACCT
where PJPTDSUM.project =  @parm1 and
PJPTDSUM.acct = PJACCT.acct and
(PJACCT.acct_type = 'RV' or
	  PJACCT.acct_type = 'EX')
order by PJPTDSUM.pjt_entity, PJACCT.sort_num, PJACCT.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_spk0] TO [MSDSL]
    AS [dbo];

