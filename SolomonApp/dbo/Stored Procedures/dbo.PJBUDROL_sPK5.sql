 create procedure PJBUDROL_sPK5 @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (16)   as
select * from PJBUDROL
where
	fsyear_num = @parm1 and
	project =  @parm2 and
acct = @parm3  and
planNbr = '  '
order by  fsyear_num, project, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBUDROL_sPK5] TO [MSDSL]
    AS [dbo];

