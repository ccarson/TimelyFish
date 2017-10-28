 CREATE PROCEDURE WOPCSetup_All

AS
   SELECT      *
   FROM        PCSetUp
   ORDER BY    SetUpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPCSetup_All] TO [MSDSL]
    AS [dbo];

