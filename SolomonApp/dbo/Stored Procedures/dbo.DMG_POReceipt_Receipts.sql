 CREATE PROCEDURE DMG_POReceipt_Receipts(
	@PONbr 		VARCHAR(10)

)
AS
	Select distinct r.*
	from POReceipts r
	inner join potran t on t.rcptnbr = r.rcptnbr
	where t.PONbr = @PONbr and r.RcptType = 'R'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_POReceipt_Receipts] TO [MSDSL]
    AS [dbo];

