 CREATE PROCEDURE WOMatlReq_InvtID_SiteID
AS
   SELECT      *
   FROM        WOMatlReq LEFT JOIN WOHeader
               ON WOMatlReq.WONbr = WOHeader.WONbr
               LEFT JOIN WOTask
               ON WOMatlReq.WONbr = WOTask.WONbr and
               WOMatlReq.Task = WOTask.Task
   ORDER BY    WOMatlReq.InvtID, WOMatlReq.SiteID, WOMatlReq.WhseLoc, WOMatlReq.WONbr


