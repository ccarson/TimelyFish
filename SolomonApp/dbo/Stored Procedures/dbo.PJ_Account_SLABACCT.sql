 create procedure PJ_Account_SLABACCT @parm1 varchar (10)   as
Select * From Account, PJ_Account, PJAcct
Where
Account.Acct = Pj_Account.gl_Acct and
Pj_Account.Acct = PJAcct.acct and
Account.Acct like @parm1 and
Account.Active = 1 and
PJAcct.id5_sw = 'L'
Order by account.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_Account_SLABACCT] TO [MSDSL]
    AS [dbo];

