 CREATE PROCEDURE POTran_SumVolume
	@ReceiptNbr varchar( 10 ),
	@IntMin smallint, @IntMax smallint
AS
	SELECT Sum(s4Future05)
	FROM POTran (NOLOCK)
	WHERE RcptNbr LIKE @ReceiptNbr
	   AND LineNbr BETWEEN @IntMin AND @IntMax
	   AND PurchaseType IN ('GI','GP','GS','GN','PI','PS')

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_SumVolume] TO [MSDSL]
    AS [dbo];

