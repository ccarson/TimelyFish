 CREATE PROCEDURE WOBuildTo_WOHeader_OIS
   @OrdNbr     varchar( 15 ),
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        WOBuildTo LEFT JOIN WOHeader
               ON WOBuildTo.WONbr = WOHeader.WONbr
   WHERE       WOBuildTo.OrdNbr = @OrdNbr and
               WOBuildTo.InvtID = @InvtID and
               WOBuildTo.SiteID = @SiteID and
               WOBuildTo.BuildToType = 'ORD' and
               WOBuildTo.Status = 'A'
   ORDER BY    WOBuildTo.WONbr, WOBuildTo.InvtID, WOBuildto.SiteID, WOHeader.WOType, WOBuildTo.BuildToType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOBuildTo_WOHeader_OIS] TO [MSDSL]
    AS [dbo];

