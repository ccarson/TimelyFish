 create procedure PJPTDROL_sWithAct @parm1 varchar (16)   as
select * from  PJPTDROL
where PJPTDROL.project =  @parm1 and
	 (PJPTDROL.act_amount <> 0 or PJPTDROL.com_amount <> 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sWithAct] TO [MSDSL]
    AS [dbo];

