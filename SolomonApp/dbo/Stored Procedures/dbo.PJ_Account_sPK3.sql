 create procedure PJ_Account_sPK3 @parm1 varchar (10)   as
Select * From PJ_Account, Account, PJACCT
Where
Pj_Account.gl_Acct =    Account.Acct and
Pj_Account.Acct    =    PJACCT.acct  and
Pj_Account.gl_Acct =    @parm1       and
Account.Active     =    1
Order by
Pj_Account.gl_Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_Account_sPK3] TO [MSDSL]
    AS [dbo];

