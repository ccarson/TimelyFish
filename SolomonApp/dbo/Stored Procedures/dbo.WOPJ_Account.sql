 CREATE PROCEDURE WOPJ_Account
   @GLAcct     varchar( 10 )
AS
   SELECT      *
   FROM        PJ_Account
   WHERE       GL_Acct = @GLAcct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJ_Account] TO [MSDSL]
    AS [dbo];

