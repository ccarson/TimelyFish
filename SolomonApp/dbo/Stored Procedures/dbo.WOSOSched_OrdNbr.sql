 CREATE PROCEDURE WOSOSched_OrdNbr
   @InvtID     varchar( 30 ),
   @SiteID     varchar( 10 )

AS
   SELECT      *
   FROM        SOLine L JOIN SOHeader H
               ON L.CpnyID = H.CpnyID and L.OrdNbr = H.OrdNbr
               JOIN SOSched S
               ON L.CpnyID = S.CpnyID and L.OrdNbr = S.OrdNbr and L.LineRef = S.LineRef
   WHERE       L.InvtID = @InvtID and
               L.SiteID LIKE @SiteID
   ORDER BY    L.OrdNbr DESC, L.LineRef, L.CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOSched_OrdNbr] TO [MSDSL]
    AS [dbo];

