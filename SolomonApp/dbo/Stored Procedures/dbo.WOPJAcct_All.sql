 CREATE PROCEDURE WOPJAcct_All
   @Acct       varchar( 16 )

AS
   SELECT      *
   FROM        PJAcct
   WHERE       Acct LIKE @Acct
   ORDER BY    Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJAcct_All] TO [MSDSL]
    AS [dbo];

