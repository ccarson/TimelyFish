 CREATE PROCEDURE WOSOSched_CustID
   @CustID     varchar( 15 ),
   @InvtID     varchar( 30 ),
   @OrdNbr     varchar( 15 )

AS
   SELECT      *
   FROM        SOHeader H JOIN SOLine L
               ON L.CpnyID = H.CpnyID and L.OrdNbr = H.OrdNbr
               JOIN SOSched S
               ON S.CpnyID = H.CpnyID and S.OrdNbr = H.OrdNbr and S.LineRef = L.LineRef
   WHERE       H.Custid = @CustID and
               L.Invtid = @InvtID and
               H.OrdNbr LIKE @OrdNbr
   ORDER BY    L.OrdNbr, L.LineRef, L.CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOSched_CustID] TO [MSDSL]
    AS [dbo];

