 create procedure PJ_ACCOUNT_FlexBill @parm1 varchar (10)   as
    SELECT acct,gl_acct 
      FROM PJ_Account
     WHERE gl_acct  like  @parm1
     ORDER BY gl_acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJ_ACCOUNT_FlexBill] TO [MSDSL]
    AS [dbo];

