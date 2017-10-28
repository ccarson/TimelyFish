 CREATE PROCEDURE WOCompCosts_WO_SO_
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
   ORDER BY    WONbr, OrdNbr, InvtID, SiteID, LineNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOCompCosts_WO_SO_] TO [MSDSL]
    AS [dbo];

