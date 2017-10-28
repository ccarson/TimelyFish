 Create	Procedure SCM_10800_ItemCost_SpecificCost
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LayerType	VarChar(2),
	@SpecificCostID	VarChar(25)
As
	Set	NoCount On

       Select *
         From ItemCost (NoLock)
        Where InvtID = @InvtID
          And SiteID = @SiteID
          And LayerType = @LayerType
          And SpecificCostID = @SpecificCostID


