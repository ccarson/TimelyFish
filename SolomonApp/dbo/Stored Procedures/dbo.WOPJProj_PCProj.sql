 CREATE PROCEDURE WOPJProj_PCProj
   @Project    varchar( 16 )

AS
   SELECT      *
   FROM        PJProj
   WHERE       Status_20 = ' ' and
               Project LIKE @Project
   ORDER BY    Project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJProj_PCProj] TO [MSDSL]
    AS [dbo];

