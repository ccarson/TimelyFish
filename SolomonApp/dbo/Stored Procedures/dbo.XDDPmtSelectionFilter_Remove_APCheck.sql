
CREATE PROCEDURE XDDPmtSelectionFilter_Remove_APCheck
   @BatNbr	varchar( 10 )

AS
  
   -- This is the start of the eBanking Payment Selection Filter process
   -- These txns will still be "Selected" in the APDoc record
   
   -- Subsequent processing will reassign these to their new batches
   -- Any removed, then will be cleaned up in APDoc.Selected (etc.)
   
   DELETE
   FROM		APCheck
   WHERE	BatNbr = @BatNbr
   
   DELETE
   FROM		APCheckDet
   WHERE	BatNbr = @BatNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDPmtSelectionFilter_Remove_APCheck] TO [MSDSL]
    AS [dbo];

