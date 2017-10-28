 create procedure PJ_Account_sPK1 @parm1 varchar (10)   as
Select * From Account, PJ_Account
Where
Account.Acct = Pj_Account.gl_Acct and
Account.Acct like @parm1 and
Account.Active = 1 Order by account.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_Account_sPK1] TO [MSDSL]
    AS [dbo];

