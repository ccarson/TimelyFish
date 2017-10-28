 CREATE PROCEDURE WORequest_SOLine
   @InvtID     	varchar( 30 ),
   @OrdNbr	varchar( 15 )

AS
   SELECT      	R.*, 				-- WORequest
   		L.*, 				-- SOLine
   		H.BuyerID,
   		H.CancelDate,
   		H.Cancelled,
   		H.CreditHold,
   		H.CreditHoldDate,
   		H.CustID,
   		H.OrdDate,
   		H.SOTypeID,
   		I.Classid,				-- Inventory
		I.Descr,
		I.InvtId,
		I.LastCost,
		I.StkUnit,
		I.TranStatusCode,
		I.ValMthd
   FROM		WORequest R JOIN SOLine L
   		ON L.CpnyID = R.CpnyID and L.OrdNbr = R.OrdNbr and L.LineRef = R.LineRef
               	LEFT OUTER JOIN SOHeader H
               	ON H.CpnyID = R.CpnyID and H.OrdNbr = R.OrdNbr
               	LEFT OUTER JOIN Inventory I
               	ON I.InvtID = R.InvtID
   WHERE       	R.InvtID LIKE @InvtID
   		and R.OrdNbr LIKE @OrdNbr
   		and L.Status = 'O'				-- open status lines only
   		and H.Cancelled = 0				-- not cancelled
   ORDER BY    	R.InvtID, L.SiteID, R.CpnyID, R.OrdNbr, R.LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WORequest_SOLine] TO [MSDSL]
    AS [dbo];

