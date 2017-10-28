 CREATE PROCEDURE WOMatlReq_Task_InvtID_SiteID
   @WONbr         varchar( 16 ),
   @Task          varchar( 32 ),
   @InvtID        varchar( 30 ),
   @SiteID  		varchar( 10 )

AS
   SELECT      *
   FROM        WOMatlReq
   WHERE       WOMatlReq.WONbr = @WONbr and
               WOMatlReq.Task = @Task and
               WOMatlReq.InvtID LIKE @InvtID and
               WOMatlReq.SiteId LIKE @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_Task_InvtID_SiteID] TO [MSDSL]
    AS [dbo];

