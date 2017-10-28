 CREATE PROCEDURE WOMatlReq_WONbr_UnIssued
   @WONbr      varchar( 16 ),
   @Task       varchar( 32 )
AS
   SELECT      *
   FROM        WOMatlReq
   WHERE       WONbr = @WONbr and
               Task = @Task and
               QtyRemaining > 0 and
               StockUsage <> 'X'
   ORDER BY    WONbr, Task, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_WONbr_UnIssued] TO [MSDSL]
    AS [dbo];

