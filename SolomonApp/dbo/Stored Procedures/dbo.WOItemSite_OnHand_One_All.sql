 CREATE PROCEDURE WOItemSite_OnHand_One_All
	@InvtID			varchar( 30 ),
	@SiteID			varchar( 10 ),
	@SpecificCostID		varchar( 25 ),
	@DecPlQty		smallint
AS

	Declare		@QtyAllSites	float
	Declare		@QtyOneSite	float

	if rtrim(@SpecificCostID) <> ''
		BEGIN
		-- One Site
		SELECT		@QtyOneSite =	Coalesce( Round(Qty-S4Future03, @DecPlQty), 0)
		FROM		ItemCost (NoLock)
		WHERE		InvtID = @InvtID
				and SiteID = @SiteID
				and SpecificCostID = @SpecificCostID
				and LayerType = 'S'
 		-- All Sites
		SELECT		@QtyAllSites = 	Coalesce( Sum( Round(Qty-S4Future03, @DecPlQty) ), 0)
		FROM 		ItemCost (NoLock)
		WHERE		InvtID = @InvtID
				and SpecificCostID = @SpecificCostID
				and LayerType = 'S'
		END
	else
		BEGIN
		-- One Site
		SELECT		@QtyOneSite =	Coalesce( Round(QtyOnHand, @DecPlQty), 0)
		FROM		ItemSite (NoLock)
		WHERE		InvtID = @InvtID
				and SiteID = @SiteID
		-- All Sites
		SELECT		@QtyAllSites = 	Coalesce( Sum( Round(QtyOnHand, @DecPlQty) ), 0)
		FROM 		ItemSite (NoLock)
		WHERE		InvtID = @InvtID
		END

	SELECT		@QtyOneSite, @QtyAllSites


