 CREATE PROCEDURE WOPJAcct_NA
   @Acct       varchar(16)

AS
   SELECT      *
   FROM        PJAcct
   WHERE       Acct_Status = 'A' and
               Acct_Type = 'NA' and
               Acct LIKE @Acct
   ORDER BY    Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJAcct_NA] TO [MSDSL]
    AS [dbo];

