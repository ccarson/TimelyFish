 create proc DMG_Plan_FetchOHPlanMatch
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select		*
	from		SOPlan
	where		InvtID = @InvtID and
	  		SiteID = @SiteID and
	  		PlanType = '10'


