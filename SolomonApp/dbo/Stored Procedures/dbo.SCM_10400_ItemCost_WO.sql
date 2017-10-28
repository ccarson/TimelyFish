 Create	Procedure SCM_10400_ItemCost_WO
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt,
	@QtyOnWO	Float Output,
	@CostOnWO	Float Output,
	@BMICostOnWO	Float Output
As
	Select	@QtyOnWO = Coalesce(Round(Sum(ItemCost.Qty), @DecPlQty), 0),
		@CostOnWO = Coalesce(Round(Sum(ItemCost.TotCost), @BaseDecPl), 0),
		@BMICostOnWO = Coalesce(Round(Sum(ItemCost.BMITotCost), @BMIDecPl), 0)
		From	ItemCost (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And LayerType = 'W'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_ItemCost_WO] TO [MSDSL]
    AS [dbo];

