 CREATE PROCEDURE POTran_LCVoucher_LandedCost
	@ReceiptNbr varchar( 10 ),
	@SiteID varchar (10),
	@InvtID varchar (30),
	@SpecificCostID varchar (25)
AS
	SELECT *
	FROM POTran
	WHERE
		RcptNbr LIKE @ReceiptNbr
		AND
		SiteID LIKE @SiteID
		AND
		InvtID LIKE @InvtID
		AND
		SpecificCostID Like @specificCostID
		and
		PurchaseType IN ('GI','GP','GS','GN','PI','PS')
	ORDER BY
		PONbr,
	   	POLineNbr


