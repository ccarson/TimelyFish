 CREATE PROCEDURE WOLocation_InvtID_Site_WhseLoc
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 ),
   @WhseLoc    varchar( 10 )
AS
   SELECT      *
   FROM        Location
   WHERE       InvtID = @InvtID and
               SiteID = @SiteID and
               WhseLoc LIKE @WhseLoc
   ORDER BY    InvtID, SiteID, WhseLoc


