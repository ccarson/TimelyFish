 CREATE PROCEDURE WOMatlReq_WONbr_Task
   @WONbr         varchar( 16 ),
   @Task          varchar( 32 ),
   @LineNbrbeg    smallint,
   @LineNbrend    smallint
AS
   SELECT      *
   FROM        WOMatlReq LEFT JOIN Inventory
               ON WOMatlReq.InvtID = Inventory.InvtID
   WHERE       WONbr = @WONbr and
               Task = @Task and
               LineNbr Between @LineNbrbeg and @LineNbrend
   ORDER BY    WOMatlReq.WONbr, Task, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_WONbr_Task] TO [MSDSL]
    AS [dbo];

