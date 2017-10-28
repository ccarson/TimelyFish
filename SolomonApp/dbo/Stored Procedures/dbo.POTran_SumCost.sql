 CREATE PROCEDURE POTran_SumCost
	@ReceiptNbr varchar( 10 ),
	@IntMin smallint, @IntMax smallint
AS
	SELECT Sum(ExtCost)
	FROM POTran (NOLOCK)
	WHERE RcptNbr LIKE @ReceiptNbr
	   AND LineNbr BETWEEN @IntMin AND @IntMax
	   AND PurchaseType IN ('GI','GP','GS','GN','PI','PS')

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_SumCost] TO [MSDSL]
    AS [dbo];

