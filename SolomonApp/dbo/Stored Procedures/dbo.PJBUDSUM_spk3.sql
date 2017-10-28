 create procedure PJBUDSUM_spk3 @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (32) , @parm4 varchar (16)   as
select * from PJBUDSUM, PJACCT
where
PJBUDSUM.fsyear_num = @parm1 and
PJBUDSUM.project  =  @parm2 and
PJBUDSUM.pjt_entity  =  @parm3 and
PJBUDSUM.acct like @parm4 and
PJBUDSUM.planNbr = '  ' and
	   PJBUDSUM.acct = pjacct.acct and
PJACCT.id1_sw = 'Y'
order by  PJBUDSUM.project, PJBUDSUM.pjt_entity, PJACCT.sort_Num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBUDSUM_spk3] TO [MSDSL]
    AS [dbo];

