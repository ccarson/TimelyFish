 CREATE PROCEDURE WOPJProj_WO_All
   @Project    varchar( 16 )

AS
   SELECT      *
   FROM        PJProj LEFT JOIN WOHeader
               ON PJProj.Project = WOHeader.WONbr
   WHERE       PJProj.Status_20 IN (' ', 'P') and
               PJProj.Project LIKE @Project
   ORDER BY    PJProj.Project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJProj_WO_All] TO [MSDSL]
    AS [dbo];

