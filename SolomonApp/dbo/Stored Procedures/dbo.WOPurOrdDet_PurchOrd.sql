 CREATE PROCEDURE WOPurOrdDet_PurchOrd
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        PurOrdDet LEFT JOIN PurchOrd
               ON PurOrdDet.PONbr = PurchOrd.PONbr
   WHERE       PurOrdDet.InvtID = @InvtID and
               PurOrdDet.SiteID LIKE @SiteID
   ORDER BY    PurOrdDet.PONbr DESC, PurOrdDet.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPurOrdDet_PurchOrd] TO [MSDSL]
    AS [dbo];

