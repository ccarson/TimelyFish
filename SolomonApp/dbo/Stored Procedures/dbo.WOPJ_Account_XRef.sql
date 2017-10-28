 CREATE PROCEDURE WOPJ_Account_XRef
   @GL_Acct    varchar( 10 )

AS
   SELECT      *
   FROM        PJ_Account LEFT JOIN WOAcctCategXRef
               ON PJ_Account.Acct = WOAcctCategXRef.Acct
   WHERE       PJ_Account.GL_Acct = @GL_Acct
   ORDER BY    PJ_Account.GL_Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJ_Account_XRef] TO [MSDSL]
    AS [dbo];

