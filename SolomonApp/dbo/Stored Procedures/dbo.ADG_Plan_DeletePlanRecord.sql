 create proc ADG_Plan_DeletePlanRecord
	@InvtID 	varchar(30),
	@SiteID 	varchar(10),
	@PlanDate	smalldatetime,
	@PlanType	varchar(2),
	@PlanRef	varchar(10)
as
	delete	SOPlan
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanDate = @PlanDate
	and	PlanType = @PlanType
	and	PlanRef = @PlanRef


