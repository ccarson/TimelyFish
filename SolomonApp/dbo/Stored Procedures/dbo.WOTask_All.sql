 CREATE PROCEDURE WOTask_All
   @WONbr      varchar( 16 ),
   @Task       varchar( 32 )
AS
   SELECT      *
   FROM        WOTask
   WHERE       WONbr = @WONbr and
               Task LIKE @Task
   ORDER BY    WONbr, Task



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOTask_All] TO [MSDSL]
    AS [dbo];

