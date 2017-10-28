 CREATE PROCEDURE WOPJProj_All
   @Project    varchar( 16 )

AS
   SELECT      *
   FROM     PJProj
   WHERE    Project LIKE @Project
   ORDER BY    Project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJProj_All] TO [MSDSL]
    AS [dbo];

