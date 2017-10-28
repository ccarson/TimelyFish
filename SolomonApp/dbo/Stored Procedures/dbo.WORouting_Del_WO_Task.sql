 CREATE PROCEDURE WORouting_Del_WO_Task
   @WONbr      varchar( 16 ),
   @Task       varchar( 32 )
AS
   DELETE
   FROM        WORouting
   WHERE       WONbr = @WONbr and
               Task = @Task



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WORouting_Del_WO_Task] TO [MSDSL]
    AS [dbo];

