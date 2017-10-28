 CREATE PROCEDURE WOSOSched_ReqDate
   @CpnyID	varchar( 10 ),
   @OrdNbr	varchar( 15 ),
   @LineRef	varchar( 5 )

AS
   SELECT      	S.ReqDate,
   		S.ReqPickDate,
   		S.Hold,
   		H.AdminHold,
   		H.CreditHold
   FROM		SOSched S LEFT OUTER JOIN SOHeader H
   		ON H.CpnyID = S.OrdNbr and H.OrdNbr = S.OrdNbr
   WHERE       	S.CpnyID = @CpnyID and
   		S.OrdNbr = @OrdNbr and
   		S.LineRef = @LineRef
   ORDER BY    	S.ReqDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOSched_ReqDate] TO [MSDSL]
    AS [dbo];

