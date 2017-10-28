 CREATE PROCEDURE WOPurOrdDet_Invtid_SiteID
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )
AS
   SELECT      *
   FROM        PurOrdDet
   WHERE       PurOrdDet.InvtID = @InvtID and
               PurOrdDet.SiteID LIKE @SiteID
   ORDER BY    PurOrdDet.PONbr DESC, PurOrdDet.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPurOrdDet_Invtid_SiteID] TO [MSDSL]
    AS [dbo];

