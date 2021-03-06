﻿ CREATE PROCEDURE POTran_SumWeight_LCVoucher
	@ReceiptNbr varchar( 10 ),
	@SiteID varchar (10),
	@InvtID varchar (30),
	@SpecificCostID varchar (25)
AS
	SELECT Sum(ExtWeight)
	FROM POTran (NOLOCK)
	WHERE
		RcptNbr LIKE @ReceiptNbr
	   	AND
		PurchaseType IN ('GI','GP','GS','GN', 'PI','PS')
		AND
		InvtID = @InvtID
		and
		SiteID = @siteID
		AND
		SpecificCostID Like @specificCostID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_SumWeight_LCVoucher] TO [MSDSL]
    AS [dbo];

