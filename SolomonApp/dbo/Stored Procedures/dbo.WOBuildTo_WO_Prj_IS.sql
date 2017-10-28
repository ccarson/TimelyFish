 CREATE PROCEDURE WOBuildTo_WO_Prj_IS
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 ),
   @Status     varchar( 1 )
AS
   SELECT      *
   FROM        WOBuildTo LEFT JOIN WOHeader
               ON WOBuildTo.WONbr = WOHeader.WONbr
               LEFT JOIN PJProj
               ON WOBuildTo.WONbr = PJProj.Project
   WHERE       WOBuildTo.InvtID = @InvtID and
               WOBuildTo.SiteID LIKE @SiteID and
               WOBuildTo.Status LIKE @Status
   ORDER BY    WOBuildTo.WONbr DESC, WOBuildTo.Status, WOBuildTo.LineNbr


