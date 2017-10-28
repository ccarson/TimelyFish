 CREATE PROCEDURE DMG_UpdateInventory_ComputerName
	@CpnyID		VARCHAR(10),					/* Company ID */
	@ComputerName	VARCHAR(21),					/* Computer Name */
	@LUpd_Prog	VARCHAR(8),
	@LUpd_User	VARCHAR(10),
	@DecPlQty	SMALLINT,
	@UpdateAll	SMALLINT
AS
/*
	WOHeader.Status
		- H - Hold
		- A - Active
		- P - Purge

	WOHeader.WOType
		- M - Manufacturing
		- R - Rework
		- P - Project Work Order

	Where	WOHeader.WOType In ('M', 'R')
		Then	WOMatlReq.WOTask Always Equals WOSetup.Mfg_Task

	Processing Stage
		- P - Plan
		- F - Firm
		- R - Released
		- O - Operation Closed
		- C - Financially Closed
	Where	WOHeader.WOType In ('M', 'R')
		Then	WOHeader.ProcStage
		Else	WOTask.ProcStage

*/
	SET NOCOUNT ON
	SET DEADLOCK_PRIORITY LOW

	BEGIN TRANSACTION

	-- Inseert any missing inventory and itemsite recrods.
	EXECUTE SCM_Plan_InsertInvt @ComputerName, @LUpd_Prog, @LUpd_User
	EXECUTE SCM_Plan_InsertItemSite @ComputerName, @CpnyID, @LUpd_Prog, @LUpd_User

	-- Delete any Non-Stock Items from INUpdateQty_Wrk.
	-- Buckets are not updated for non-stock items.
	IF @ComputerName = '%'
		DELETE	INUpdateQty_Wrk
		FROM	INUpdateQty_Wrk INU (NOLOCK)
		JOIN 	Inventory I (NOLOCK)
		ON 	INU.InvtID = I.InvtID
		WHERE	I.StkItem <> 1
		AND	INU.ComputerName  LIKE @ComputerName
	Else
		DELETE	INUpdateQty_Wrk
		FROM	INUpdateQty_Wrk INU (NOLOCK)
		JOIN 	Inventory I (NOLOCK)
		ON 	INU.InvtID = I.InvtID
		WHERE	I.StkItem <> 1
		AND	INU.ComputerName  = @ComputerName

	-- Update buckets for ItemSite, Location, LotSerMst, & ItemCost.
	EXECUTE	SCM_Plan_POQty @ComputerName, @LUpd_Prog, @LUpd_User, @DecPlQty
	EXECUTE	SCM_Plan_SOQty @ComputerName, @LUpd_Prog, @LUpd_User, @DecPlQty, @UpdateAll
	EXECUTE	SCM_Plan_WODemand @ComputerName, @LUpd_Prog, @LUpd_User, @DecPlQty
	EXECUTE	SCM_Plan_WOSupply @ComputerName, @LUpd_Prog, @LUpd_User, @DecPlQty
	EXECUTE	SCM_Plan_OtherQty @ComputerName, @LUpd_Prog, @LUpd_User, @DecPlQty
	EXECUTE	Plan_ProjectInventory @ComputerName, @LUpd_Prog, @LUpd_User, @DecPlQty
		/* Calculate Quantity Available
	   We are passing in zero for the QtyAvail parameter since we should never come through here unless in
	   CPS Off mode, thus the procedure will use the formula rather than the QtyAvail value provided.
	*/
	EXECUTE	SCM_Plan_QtyAvail @ComputerName, '', '', @LUpd_Prog, @LUpd_User, 0, @DecPlQty

	-- Delete processed records
	EXECUTE	SCM_Delete_INUpdateQty_Wrk @ComputerName

	COMMIT TRANSACTION


