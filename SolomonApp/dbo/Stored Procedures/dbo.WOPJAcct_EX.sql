 CREATE PROCEDURE WOPJAcct_EX
   @Acct       varchar(16)

AS
   SELECT      *
   FROM        PJAcct
   WHERE       Acct_Status = 'A' and
               Acct_Type = 'EX' and
               Acct LIKE @Acct
   ORDER BY    Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJAcct_EX] TO [MSDSL]
    AS [dbo];

