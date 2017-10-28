 Create Proc ADG_GetQtyAvail_ItemSite
	@InvtID		Varchar(30),
	@SiteID		Varchar(10)
As

SELECT	QtyAvail
	FROM	ItemSite (NOLOCK)
	WHERE	InvtID = @InvtID AND SiteID = @SiteID


