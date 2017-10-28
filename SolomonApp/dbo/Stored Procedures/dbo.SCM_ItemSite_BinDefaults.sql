 create proc SCM_ItemSite_BinDefaults
	@InvtID		varchar( 30 ),
	@SiteID		varchar( 10 )
	AS

	SELECT		DfltPickBin, DfltPutAwayBin, DfltRepairBin, DfltVendorBin
	FROM		ITEMSITE
	WHERE		InvtID = @InvtID
	  and		SiteID = @SiteID

