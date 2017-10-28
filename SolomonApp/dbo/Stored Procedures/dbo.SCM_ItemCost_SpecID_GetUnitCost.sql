 Create	Procedure SCM_ItemCost_SpecID_GetUnitCost
	@InvtID varchar(30),
	@SiteID varchar(10),
	@SpecificCostID varchar(25)

as

	Select 	UnitCost
	from 	ItemCost
        where 	InvtId = @InvtID
   	  and 	SiteId = @SiteID
	  and 	SpecificCostId = @SpecificCostID


