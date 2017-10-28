 create procedure PJACCT_SALL @parm1 varchar (16)  as
select * from PJACCT
where acct like @parm1
order by acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACCT_SALL] TO [MSDSL]
    AS [dbo];

