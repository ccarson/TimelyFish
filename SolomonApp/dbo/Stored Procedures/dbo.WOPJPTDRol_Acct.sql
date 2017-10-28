 CREATE PROCEDURE WOPJPTDRol_Acct
   @Project    varchar( 16 ),
   @Acct       varchar( 16 )

AS
   SELECT      *
   FROM     PJPTDRol
   WHERE    Project = @Project and
         Acct = @Acct
   ORDER BY    Project, Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJPTDRol_Acct] TO [MSDSL]
    AS [dbo];

