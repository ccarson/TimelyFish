 create procedure PJPTDSUM_spk3 @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16)   as
select * from PJPTDSUM, PJACCT
where PJPTDSUM.project  =  @parm1 and
PJPTDSUM.pjt_entity  =  @parm2 and
PJPTDSUM.acct like @parm3 and
	   PJPTDSUM.acct = pjacct.acct and
PJACCT.id1_sw = 'Y'
order by  PJPTDSUM.project, PJPTDSUM.pjt_entity, PJACCT.sort_Num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_spk3] TO [MSDSL]
    AS [dbo];

