 create procedure PJACCT_SPK0 @parm1 varchar (16)  as
select * from PJACCT
where acct = @parm1
order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_SPK0] TO [MSDSL]
    AS [dbo];

