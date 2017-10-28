 CREATE PROCEDURE POTran_SumQty_LCVoucher
	@ReceiptNbr varchar( 10 ),
	@SiteID varchar (10),
	@InvtID varchar (30),
	@SpecificCostID varchar (25)
AS
	SELECT Sum(Qty)
	FROM POTran (NOLOCK)
	WHERE
		RcptNbr LIKE @ReceiptNbr
	   	AND
		PurchaseType IN ('GI','GP','GS','GN','PI','PS')
		AND
		InvtID = @InvtID
		and
		SiteID = @siteID
		AND
		SpecificCostID Like @specificCostID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_SumQty_LCVoucher] TO [MSDSL]
    AS [dbo];

