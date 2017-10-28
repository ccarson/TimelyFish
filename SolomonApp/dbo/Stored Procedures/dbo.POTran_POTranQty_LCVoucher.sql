 CREATE PROCEDURE POTran_POTranQty_LCVoucher
	@ReceiptNbr varchar( 10 ),
	@SiteID varchar (10),
	@InvtID varchar (30),
	@SpecificCostID varchar (25)
AS
	SELECT round(sum(case when POTran.UnitMultDiv = 'D' and POTran.CnvFact <> 0 then
                                   round(POTran.Qty / POTran.CnvFact, INSetup.DecPlQty)
                              else
                                   round(POTran.Qty * POTran.CnvFact, INSetup.DecPlQty)
                               end), MAX(INSetup.DecPlQty))
	FROM POTran, Inventory (NoLOCK), INSetup (NOLOCK)
	WHERE
		POTran.InvtID = Inventory.InvtID
		AND
		POTran.RcptNbr LIKE @ReceiptNbr
	   	AND
		POTran.PurchaseType IN ('GI','GS', 'PI','PS')
		AND
		POTran.InvtID = @InvtID
		and
		POTran.SiteID = @siteID
		AND
		POTran.SpecificCostID Like @specificCostID
		and
		Inventory.ValMthd in ('S','L','F','A')


