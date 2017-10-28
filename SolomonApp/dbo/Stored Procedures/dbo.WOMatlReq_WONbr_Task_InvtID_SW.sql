 CREATE PROCEDURE WOMatlReq_WONbr_Task_InvtID_SW
   @WONbr         varchar( 16 ),
   @Task          varchar( 32 ),
   @InvtID        varchar( 30 ),
   @SiteID        varchar( 10 ),
   @WhseLoc       varchar( 10 )
AS
   SELECT      *
   FROM        WOMatlReq
   WHERE       WONbr = @WONbr and
               Task = @Task and
               InvtID = @InvtID and
               SiteID = @SiteID and
               WhseLoc = @WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_WONbr_Task_InvtID_SW] TO [MSDSL]
    AS [dbo];

