 CREATE PROCEDURE WOMatlReq_WOHeader_WOTask_InvtID_SiteID
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        WOMatlReq LEFT JOIN WOHeader
               ON WOMatlReq.WONbr = WOHeader.WONbr
               LEFT JOIN WOTask
               ON WOMatlReq.WONbr = WOTask.WONbr and
               WOMatlReq.Task = WOTask.Task
   WHERE       WOMatlReq.Invtid = @InvtID and
               WOMatlReq.SiteID LIKE @SiteID
   ORDER BY    WOMatlReq.WONbr, WOMatlReq.Task DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOMatlReq_WOHeader_WOTask_InvtID_SiteID] TO [MSDSL]
    AS [dbo];

