 CREATE PROCEDURE WOAcctCategXRef_All
   @Acct       varchar( 16 )
AS
   SELECT      *
   FROM        WOAcctCategXRef
   WHERE       Acct LIKE @Acct
   ORDER BY    Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOAcctCategXRef_All] TO [MSDSL]
    AS [dbo];

