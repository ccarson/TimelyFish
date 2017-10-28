 CREATE PROCEDURE WOMatlReq_Task_InvtID
   @WONbr         varchar( 16 ),
   @Task          varchar( 32 ),
   @InvtID        varchar( 30 )

AS
   SELECT      *
   FROM        WOMatlReq LEFT JOIN Inventory
               ON WOMatlReq.InvtID = Inventory.InvtID
   WHERE       WOMatlReq.WONbr = @WONbr and
               WOMatlReq.Task = @Task and
               WOMatlReq.InvtID LIKE @InvtID
   ORDER BY    WOMatlReq.WONbr, WOMatlReq.Task, WOMatlReq.InvtID


