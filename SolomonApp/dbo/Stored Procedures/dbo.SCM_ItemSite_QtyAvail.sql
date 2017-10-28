 CREATE	PROCEDURE SCM_ItemSite_QtyAvail
	@InvtID		VarChar(30),
	@SiteID		VarChar(10)
AS
	IF PATINDEX('%[%]%', @SiteID) > 0
		SELECT  QtyAvail
		FROM	ItemSite (NoLock)
		WHERE	InvtID = @InvtID
		  AND 	SiteID + '' LIKE @SiteID
	ELSE
		SELECT QtyAvail
		FROM	ItemSite (NoLock)
		WHERE	InvtID = @InvtID
		  AND	SiteID = @SiteID


