 create procedure PJPTDROL_sPK5 @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJPTDROL
where project =  @parm1 and
acct = @parm2
order by project, acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sPK5] TO [MSDSL]
    AS [dbo];

