 CREATE PROCEDURE WOPJPEnt_PJProj
   @Project    varchar( 16 ),
   @Task       varchar( 32 )

AS
   SELECT      *
   FROM        PJPEnt LEFT JOIN PJProj
               ON PJPEnt.Project = PJProj.Project
   WHERE       PJPEnt.Project = @Project and
               PJPEnt.PJT_Entity = @Task
   ORDER BY    PJPEnt.Project, PJPEnt.PJT_Entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJPEnt_PJProj] TO [MSDSL]
    AS [dbo];

