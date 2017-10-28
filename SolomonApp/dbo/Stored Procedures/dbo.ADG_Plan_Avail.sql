 create proc ADG_Plan_Avail
	@InvtID 	varchar(30),
	@SiteID 	varchar(10)
as
	select	*
	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType not in ('40', '68', '70', '75') -- QAvail, Supply, Demand only

	order by
		PrioritySeq,
		Priority,
		PriorityDate,
		PriorityTime


