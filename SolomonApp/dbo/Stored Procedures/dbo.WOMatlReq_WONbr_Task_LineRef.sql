 CREATE PROCEDURE WOMatlReq_WONbr_Task_LineRef
   @WONbr         varchar( 16 ),
   @Task          varchar( 32 ),
   @LineRef			varchar( 5 )
AS
   SELECT      *
   FROM        WOMatlReq LEFT JOIN Inventory
               ON WOMatlReq.InvtID = Inventory.InvtID
   WHERE       WONbr = @WONbr and
               Task = @Task and
               LineRef LIKE @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_WONbr_Task_LineRef] TO [MSDSL]
    AS [dbo];

