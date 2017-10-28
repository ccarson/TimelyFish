 CREATE PROCEDURE WOSetup_All
AS
   SELECT      *
   FROM        WOSetup
   ORDER BY    SetUpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSetup_All] TO [MSDSL]
    AS [dbo];

