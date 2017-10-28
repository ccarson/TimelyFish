 CREATE PROCEDURE WOGLSetup_Ledger
AS
   SELECT      *
   FROM        GLSetup LEFT JOIN Ledger
               ON GLSetup.LedgerID = Ledger.LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOGLSetup_Ledger] TO [MSDSL]
    AS [dbo];

