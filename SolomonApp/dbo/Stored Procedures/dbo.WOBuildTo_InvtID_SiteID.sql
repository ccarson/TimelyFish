 CREATE PROCEDURE WOBuildTo_InvtID_SiteID
AS
   SELECT      *
   FROM        WOBuildTo LEFT JOIN WOHeader
   ON          WOBuildTo.WONbr = WOHeader.WONbr
   WHERE       WOBuildTo.Status = 'P'
   ORDER BY    WOBuildTo.InvtID, WOBuildTo.SiteID, WOBuildTo.WONbr


