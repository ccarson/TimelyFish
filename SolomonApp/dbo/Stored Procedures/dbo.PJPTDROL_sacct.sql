 create procedure PJPTDROL_sacct @parm1 varchar (16)   as
select * from PJPTDROL
where acct = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_sacct] TO [MSDSL]
    AS [dbo];

