 create proc ADG_Plan_PlanDemandFloat
	@InvtID 	varchar(30),
	@SiteID 	varchar(10)
as
	select	*
	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('60', '62', '64', '66') -- Floating Demand types
		-- When Work Orders are included in CPS On, then add '80', '82'

	order by
		PrioritySeq,
		Priority,
		PriorityDate,
		PriorityTime


