 CREATE PROCEDURE WOPJ_Account_Acct_GL
   @PJAcct     varchar( 16 ),
   @Acct       varchar( 16 )

AS
   SELECT      *
   FROM        Account LEFT JOIN PJ_Account
               ON Account.Acct = PJ_Account.GL_Acct
   WHERE       PJ_Account.Acct = @PJAcct and
               Account.Acct LIKE @Acct and
               Account.Active = 1
   ORDER BY    Account.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJ_Account_Acct_GL] TO [MSDSL]
    AS [dbo];

