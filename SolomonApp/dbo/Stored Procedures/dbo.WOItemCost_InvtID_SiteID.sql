 CREATE PROCEDURE WOItemCost_InvtID_SiteID
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        ItemCost
   WHERE       InvtID = @InvtID and
               SiteID LIKE @SiteID
   ORDER BY    InvtID, SiteID, SpecificCostID, RcptNbr, RcptDate


