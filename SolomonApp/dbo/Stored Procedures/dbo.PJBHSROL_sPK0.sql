 create procedure PJBHSROL_sPK0 @parm1 varchar (16) , @parm2 varchar (16)  , @parm3 varchar (6) as
select * from PJBHSROL
where project =  @parm1 and
acct = @parm2 and
fiscalno = @parm3
order by project, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBHSROL_sPK0] TO [MSDSL]
    AS [dbo];

