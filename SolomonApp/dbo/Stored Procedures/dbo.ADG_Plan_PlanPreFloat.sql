 create proc ADG_Plan_PlanPreFloat
	@InvtID 	varchar(30),
	@SiteID 	varchar(10)
as
	select	*
	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('10', '20', '21', '25', '26', '28', '29', '50', '52')
		-- All Supply and Demand, up to Floating Demand
		-- When Work Orders are included in CPS On, then add '15', '16', '17', '18', '54'

	order by
		PlanDate


