 CREATE PROCEDURE WOPJProj_WO_Only
   @Project    varchar( 16 )

AS
   SELECT      *
   FROM        PJProj
   WHERE       Project LIKE @Project and
               PJProj.Status_20 IN ('M', 'R')
   ORDER BY    Project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJProj_WO_Only] TO [MSDSL]
    AS [dbo];

