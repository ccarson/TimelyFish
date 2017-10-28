 CREATE PROCEDURE SCM_Plan_WOSupply
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@DecPlQty	SmallInt
AS
	SET NOCOUNT ON

	/* Calculate the Quantity Firm Supply and Quantity Released Supply for the current InvtID and SiteID. */
	/* Update the Quantity Work Order Firm Supply and Quantity Work Order Release Supply into ItemSite
	for the current InvtID and SiteID. */
	UPDATE	ItemSite
	SET	QtyWOFirmSupply = Coalesce(D.Qty_FS, 0),		/* Quantity Firm Supply */
		QtyWORlsedSupply = Coalesce(D.Qty_RS, 0),		/* Quantity Released Supply */
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	FROM	Itemsite

	JOIN	INUpdateQty_Wrk INU (NOLOCK)
	  ON 	INU.InvtID = ItemSite.InvtID
	  AND 	INU.SiteID = ItemSite.SiteID
	  AND	INU.ComputerName + '' LIKE @ComputerName
	  AND 	INU.UpdateWOSupply = 1

	LEFT JOIN (SELECT ROUND(SUM(
			CASE
			WHEN WOHeader.ProcStage = 'F' THEN	/* Quantity Firm Supply */
				WOBuildTo.QtyRemaining
			ELSE
				0
			END), @DecPlQty) AS Qty_FS,

			ROUND(SUM(
			CASE
			WHEN WOHeader.ProcStage = 'R' THEN	/* Quantity Released Supply */
				WOBuildTo.QtyRemaining
			ELSE
				0
			END), @DecPlQty) AS Qty_RS,
			WOBuildTo.InvtID, WOBuildTo.SiteID

			FROM	WOBuildTo (NOLOCK)

			JOIN 	WOHeader (NOLOCK)
			  ON 	WOBuildTo.WONbr = WOHeader.WONbr

			WHERE	WOBuildTo.Status = 'P'		/* Planned Target */
			  AND 	WOHeader.Status <> 'P'		/* Not Purged */
			  AND 	WOHeader.WOType <> 'P'		/* Not a Project Work Order */

			GROUP BY WOBuildTo.InvtID, WOBuildTo.SiteID) AS D
	  ON 	D.InvtID = INU.InvtID		/* Inventory ID */
	  AND 	D.SiteID = INU.SiteID		/* Site ID */



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Plan_WOSupply] TO [MSDSL]
    AS [dbo];

