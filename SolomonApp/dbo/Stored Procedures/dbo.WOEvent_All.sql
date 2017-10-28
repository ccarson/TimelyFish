 CREATE PROCEDURE WOEvent_All
   @WONbr      varchar( 16 )
AS
   SELECT      *
   FROM        WOEvent
   WHERE       WONbr LIKE @WONbr
   ORDER BY    WONbr DESC, EventID DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOEvent_All] TO [MSDSL]
    AS [dbo];

