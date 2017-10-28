 CREATE PROCEDURE PO_Delete
	@CpnyId		varchar(10),
	@PerClosed	varchar(6)
AS

       -- Delete PurchOrd records those are before specified period and has Status = 'Completed'
	  DELETE  FROM PurchOrd
	  WHERE PerClosed <= @PerClosed
		  AND PerClosed <> ''
		  AND Status in ('M','X')
		  AND CpnyID = @CpnyId

       -- Also Delete PurchOrd records with Status 'Quote' and perent < specified period
	  DELETE  FROM PurchOrd
	  WHERE Perent <= @PerClosed
	  	AND Perent <> ''
	  	AND Status = 'Q'
	  	AND CpnyID = @CpnyId

       -- Delete from POreceipt for above PONbr
          DELETE r FROM POReceipt r
          inner join potran t on t.rcptnbr = r.rcptnbr
	  WHERE r.CpnyID = @CpnyId
	  	AND t.PoNbr NOT IN (SELECT PONbr FROM PurchOrd WHERE CpnyID = @CpnyId)

       -- Delete POReqHdr for the above ponbr
	  DELETE FROM POReqHdr
	  WHERE CpnyID = @CpnyId
	  	AND PONbr NOT IN (SELECT PONbr FROM PurchOrd WHERE CpnyID = @CpnyId)

	--Execute Proc which Deletes all details with no header records
	  Execute PO_Delete_Orphans @CpnyId

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PO_Delete] TO [MSDSL]
    AS [dbo];

