 create proc ADG_Plan_SupplyFromPlanKitAssy
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select	PlanDate,
		'Qty' = sum(Qty)

	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('25', '26')

	group by
		PlanDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_SupplyFromPlanKitAssy] TO [MSDSL]
    AS [dbo];

