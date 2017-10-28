 CREATE PROCEDURE WOKit_Site
   @KitID      varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        Kit
   WHERE       KitID LIKE @KitID and
               SiteID LIKE @SiteID and
               Status = 'A'
   ORDER BY    KitID, SiteID, Status


