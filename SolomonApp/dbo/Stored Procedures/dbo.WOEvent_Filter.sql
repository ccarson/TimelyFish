 CREATE PROCEDURE WOEvent_Filter
   @WONbr         varchar( 16 ),
   @PerPostbeg    varchar( 6 ),
   @PerPostend    varchar( 6 ),
   @ActionID      varchar( 3 ),
   @BatchID       varchar( 5 )
AS
   SELECT         *
   FROM           WOEvent
   WHERE          WONbr LIKE @WONbr and
                  PerPost BETWEEN @PerPostbeg and @PerPostend and
                  ActionID LIKE @ActionID and
                  BatchID LIKE @BatchID
   ORDER BY       WONbr DESC, EventID DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOEvent_Filter] TO [MSDSL]
    AS [dbo];

