 create procedure PJ_Account_sPK2 @parm1 varchar (10)   as
select * from PJ_Account
where gl_acct  =  @parm1
order by gl_acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_Account_sPK2] TO [MSDSL]
    AS [dbo];

