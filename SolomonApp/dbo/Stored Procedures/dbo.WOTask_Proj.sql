 CREATE PROCEDURE WOTask_Proj
   @Project    varchar( 16 ),
   @Task       varchar( 32 )

AS
   SELECT      *
   FROM        PJPEnt
   WHERE       Project = @Project and
               PJT_Entity LIKE @Task
   ORDER BY    Project, PJT_Entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOTask_Proj] TO [MSDSL]
    AS [dbo];

