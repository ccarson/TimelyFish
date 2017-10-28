 create procedure PJ_Account_sPK5 @parm1 varchar (250) , @parm2 varchar (10)  as
Select * From Account, PJ_Account
Where
Account.Acct = Pj_Account.gl_Acct and
Account.Acct <> @parm1 and
Account.Acct like @parm2 and
Account.Active = 1 Order by account.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_Account_sPK5] TO [MSDSL]
    AS [dbo];

