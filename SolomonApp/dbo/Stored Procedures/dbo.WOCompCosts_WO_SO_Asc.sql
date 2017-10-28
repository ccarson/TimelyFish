 CREATE PROCEDURE WOCompCosts_WO_SO_Asc
   @WONbr      varchar( 16 ),
   @OrdNbr     varchar( 15 ),
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        WOSOCompCost
   WHERE       WONbr = @WONbr and
               OrdNbr = @OrdNbr and
               InvtID = @InvtID and
               SiteID = @SiteID
   ORDER BY    WONbr, OrdNbr, InvtID, SiteID, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOCompCosts_WO_SO_Asc] TO [MSDSL]
    AS [dbo];

