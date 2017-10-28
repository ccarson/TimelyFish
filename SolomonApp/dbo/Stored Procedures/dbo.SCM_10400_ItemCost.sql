 Create	Procedure SCM_10400_ItemCost
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LayerType	VarChar(2),
	@SpecificCostID	VarChar(25),
	@RcptDate	SmallDateTime,
	@RcptNbr	VarChar(15)
As
	Select	Top 1
		*
		From	ItemCost (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And LayerType = @LayerType
			And SpecificCostID = @SpecificCostID
			And RcptDate = @RcptDate
			And RcptNbr = @RcptNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_ItemCost] TO [MSDSL]
    AS [dbo];

