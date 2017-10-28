 Create	Procedure SCM_IRTransferSiteID_CirRefCheck
	@CpnyID			VarChar(10),
	@InvtID			VarChar(30),
	@SiteID			VarChar(10),
	@FromSiteID		VarChar(10)
As
	While	RTrim(@FromSiteID) <> ''
	Begin
		Select	@FromSiteID =	Case	When	ItemSite.IRSourceCode = '3'
							Then	ItemSite.IRTransferSiteID
						When	Inventory.IRSourceCode = '3'
							Then	Inventory.IRTransferSiteID
						When	Site.IRSourceCode = '3'
							Then	Site.IRTransferSiteID
						Else	''
					End
			From	ItemSite (NoLock) Inner Join Inventory (NoLock)
				On ItemSite.InvtID  = Inventory.InvtID
				Inner Join Site (NoLock)
				On ItemSite.SiteID = Site.SiteID
				And ItemSite.CpnyID = Site.CpnyID
			Where	ItemSite.InvtID = @InvtID
				And ItemSite.SiteID = @FromSiteID
				And ItemSite.CpnyID = @CpnyID
				And (ItemSite.IRSourceCode = '3'
				Or Inventory.IRSourceCode = '3'
				Or Site.IRSourceCode = '3')
				And (ItemSite.SiteID <> Inventory.IRTransferSiteID)

		/* End of Chain Found */
		If	@@RowCount = 0
			Break

		/* Circular Reference Would Occur */
		If	@FromSiteID = @SiteID
			Break
	End

	If	@FromSiteID = @SiteID
		Select	Cast(0 As SmallInt)
	Else
		Select	Cast(1 As SmallInt)


