 CREATE PROCEDURE DMG_POTran_Receipts_Count  (
	@PONbr 		VARCHAR(10),
	@POLineRef	VARCHAR(5),
	@RcptNbr	VARCHAR(10)

)
AS

	Select 	Count(*)
	from 	POTran, POReceipt
	where 	POTran.PONbr = @PONbr
	  and	POTran.POLineRef Like @POLineRef
	  and	POTran.RcptNbr Like @RcptNbr
	  and	POTran.RcptNbr = POReceipt.RcptNbr
	  and 	POTran.TranType = 'R'
	  and	POReceipt.Rlsed = 1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POTran_Receipts_Count] TO [MSDSL]
    AS [dbo];

