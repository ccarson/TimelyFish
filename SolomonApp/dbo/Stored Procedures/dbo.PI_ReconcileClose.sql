 Create Procedure PI_ReconcileClose
	@p_PIID 	VarChar(10),
	@p_SiteID 	VarChar(10),
	@p_DateFreez 	SmallDateTime,
	@p_PITagType	Char(1)

As
	Set	NoCount On

	Declare	@SQLError	Integer,
		@DecPlQty	SmallInt,
		@BaseDecPl	SmallInt

	Select	@BaseDecPl = BaseDecPl,					/*	Base Currency Decimal Position	*/
		@DecPlQty = DecPlQty					/*	Quantity Decimal Position	*/
		From	vp_DecPl

	Begin Transaction

	Create	Table #Adj10397_2
		(
		InvtID		VarChar(30),
		TotQtyDiff	Float,
		TotBookQty	Float,
		TotAdjAmt	Float
		)

	Insert	Into #Adj10397_2
	Select	PIDetail.InvtID,
		TotQtyDiff = Round(SUM(PIDetail.physqty - PIDetail.bookqty), @DecPlQty),
		TotBookQty = Round(SUM(PIDetail.bookqty), @DecPlQty),
		TotAdjAmt = Round(Round(SUM(PIDetail.physqty - PIDetail.bookqty), @DecPlQty) * PIDetail.UnitCost, @BaseDecPl)
		From	PIDetail
		Where	PIDetail.PIID = @P_PIID
		Group by PIDetail.InvtID, PIDetail.UnitCost

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

	Update	ItemSite
		Set	LastBookQty = Adj.TotBookQty,
			LastVarAmt = Adj.TotAdjAmt,
			LastVarQty = Adj.TotQtyDiff,
			LastVarPct = 	Case	When Round(Adj.TotBookQty, @DecPlQty) = 0
							Then 0
						Else Round(Adj.TotQtyDiff / Adj.TotBookQty, @DecPlQty) * 100
					End,
			LastCountDate = @p_DateFreez,
			CountStatus = 	Case	When @p_PITagType = 'I'	/*	Count by Item	*/
							Then 'A'	/*	Available	*/
						Else ItemSite.CountStatus
					End
			From	ItemSite Join #Adj10397_2 Adj
				On ItemSite.InvtID = Adj.InvtID
			Where	ItemSite.SiteID = @p_SiteID

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

	Update	Inventory
		Set	LastBookQty = Adj.TotBookQty,
			LastVarAmt = Adj.TotAdjAmt,
			LastVarQty = Adj.TotQtyDiff,
			LastVarPct = 	Case	When Round(Adj.TotBookQty, @DecPlQty) = 0
							Then 0
						Else Round(Adj.TotQtyDiff / Adj.TotBookQty, @DecPlQty) * 100
					End,
			LastCountDate = @p_DateFreez,
			LastSiteID = @p_SiteID
			From	Inventory Join #Adj10397_2 Adj
				On Inventory.InvtID = Adj.InvtID

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

	Create	Table #Adj10397_3
		(
		WhseLoc		VarChar(10),
		TotQtyDiff	Float,
		TotBookQty	Float,
		TotAdjAmt	Float
		)

	Insert	Into #Adj10397_3
	Select	PIDetail.WhseLoc,
		TotQtyDiff = Round(SUM(PIDetail.physqty - PIDetail.bookqty), @DecPlQty),
		TotBookQty = Round(SUM(PIDetail.bookqty), @DecPlQty),
		TotAdjAmt = Round(Round(SUM(PIDetail.physqty - PIDetail.bookqty), @DecPlQty) * PIDetail.UnitCost, @BaseDecPl)
		From	PIDetail
		Where	PIDetail.PIID = @P_PIID
		Group by PIDetail.WhseLoc, PIDetail.UnitCost

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

	Update	LocTable
		Set	LastBookQty = Adj.TotBookQty,
			LastVarAmt = Adj.TotAdjAmt,
			LastVarQty = Adj.TotQtyDiff,
			LastVarPct = 	Case	When Round(Adj.TotBookQty, @DecPlQty) = 0
							Then 0
						Else Round(Adj.TotQtyDiff / Adj.TotBookQty, @DecPlQty) * 100
					End,
			LastCountDate = @p_DateFreez,
			CountStatus = 	Case	When @p_PITagType = 'L'	/*	Count by Location	*/
							Then 'A'	/*	Available	*/
						Else LocTable.CountStatus
					End
			From	LocTable Join #Adj10397_3 Adj
				On LocTable.WhseLoc = Adj.WhseLoc
			Where	LocTable.SiteID = @p_SiteID

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

	If	@p_PITagType = 'L'	/*	Count by Item	*/
	Begin
		Update	Location
			Set	CountStatus = 'A'	/*	Available	*/
			From	Location Join #Adj10397_3 Adj
				On Location.WhseLoc = Adj.WhseLoc
			Where	Location.SiteID = @p_SiteID
	End

/*	Preserve SQL Error Number and Determine if an error occurred.	*/
	Set	@SQLError = @@Error
	If	@SQLError <> 0 Goto Abort

Commit Transaction

Goto FINISH

ABORT:
RollBack Transaction

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PI_ReconcileClose] TO [MSDSL]
    AS [dbo];

