 CREATE PROCEDURE WOPJPEnt_WOTask
   @Project    varchar( 16 ),
   @Task       varchar( 32 )

AS
   SELECT      *
   FROM        PJPEnt LEFT JOIN WOTask
               ON PJPEnt.Project = WOTask.WONbr and
               PJPEnt.PJT_Entity = WOTask.Task
   WHERE       PJPEnt.Project = @Project and
               PJPEnt.PJT_Entity LIKE @Task
   ORDER BY    PJPEnt.Project, PJPEnt.PJT_Entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJPEnt_WOTask] TO [MSDSL]
    AS [dbo];

