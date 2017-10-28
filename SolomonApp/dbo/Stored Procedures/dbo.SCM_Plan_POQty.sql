 CREATE PROCEDURE SCM_Plan_POQty
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@DecPlQty	SmallInt
AS
	SET NOCOUNT ON

	/* Update the Quantity on Purchase Orders and the Quantity on Drop Shipments into ItemSite for the current
	InvtID and SiteID. */

	UPDATE	ItemSite
	SET	QtyOnPO = Coalesce(D.QtyOnPO,0),		/* End of Sum, Round and Coalesce */
		QtyOnDP = Coalesce(D.QtyOnDP,0),		/* End of Sum, Round and Coalesce */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
		FROM	ItemSite
		JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON 	INU.InvtID = ItemSite.InvtID					/* Inventory ID */
	  AND 	INU.SiteID = ItemSite.SiteID					/* Site ID */
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND	INU.UpdatePO = 1

	LEFT JOIN (SELECT POD.InvtID, POD.SiteID,
			Round(Sum(					/* Begin of Coalesce, Round and Sum  */
			Case
			When POD.PurchaseType <> 'GD' Then /* No Drop Ship Lines, nor Inventory for Projects */
				Case
				When POD.CnvFact = 0 Then
       		               		Round(POD.QtyOrd - POD.QtyRcvd, @DecPlQty)
				Else
					Case
					When POD.UnitMultDiv = 'D' Then
						Round(Round(POD.QtyOrd - POD.QtyRcvd, @DecPlQty) / POD.CnvFact, @DecPlQty)
					Else
						Round(Round(POD.QtyOrd - POD.QtyRcvd, @DecPlQty) * POD.CnvFact, @DecPlQty)
					End
				End
			Else
				0
			End), @DecPlQty) AS QtyOnPO,			/* End of Sum, Round and Coalesce */

			Round(Sum(					/* Begin of Coalesce, Round and Sum  */
			Case
			When POD.PurchaseType = 'GD' Then		/* Only Drop Ship Lines */
				Case
				When POD.CnvFact = 0 Then
       		               		Round(POD.QtyOrd - POD.QtyRcvd, @DecPlQty)
				Else
					Case
					When POD.UnitMultDiv = 'D' Then
						Round(Round(POD.QtyOrd - POD.QtyRcvd, @DecPlQty) / POD.CnvFact, @DecPlQty)
					Else
						Round(Round(POD.QtyOrd - POD.QtyRcvd, @DecPlQty) * POD.CnvFact, @DecPlQty)
					End
				End
			Else
				0
			End), @DecPlQty) AS QtyOnDp		/* End of Sum, Round and Coalesce */

		FROM	PurOrdDet POD (NOLOCK)

		INNER JOIN PurchOrd p (NOLOCK)
		ON 	POD.POnbr = p.POnbr
			WHERE	POD.OpenLine = 1					/* Only Open Lines */
			AND p.Status IN ('O','P')				/* Status = Open or Printed */
			AND p.POType IN ('OR','DP')				/* Type = Regular Order or Drop Ship */
			AND POD.PurchaseType <> 'GP' AND POD.PurchaseType <> 'GN'	/* PurchType = Goods for Project and Non-Inventory Goods */
			AND POD.QtyOrd > POD.QtyRcvd
		GROUP BY POD.InvtID, POD.SiteID) AS D

	  ON 	D.InvtID = INU.InvtID					/* Inventory ID */
	  AND 	D.SiteID = INU.SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_POQty] TO [MSDSL]
    AS [dbo];

