 CREATE PROCEDURE WOSOLine_SOSched_All
   @CpnyID	varchar( 10 ),
   @OrdNbr     	varchar( 15 ),
   @LineRef    	varchar( 5 )

AS
   SELECT      *
   FROM        SOLine L JOIN SOSched S
               ON S.CpnyID = L.CpnyID and S.OrdNbr = L.OrdNbr and S.LineRef = L.LineRef
   WHERE       L.CpnyID = @CpnyID and
               L.OrdNbr = @OrdNbr and
               L.LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOLine_SOSched_All] TO [MSDSL]
    AS [dbo];

