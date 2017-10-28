 CREATE PROCEDURE WOPJAcct_Rev_Ex
   @Acct       varchar( 16 )

AS
   SELECT      *
   FROM        PJAcct
   WHERE       Acct LIKE @Acct and
               Acct_Type IN ('RV','EX')
   ORDER BY    Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJAcct_Rev_Ex] TO [MSDSL]
    AS [dbo];

