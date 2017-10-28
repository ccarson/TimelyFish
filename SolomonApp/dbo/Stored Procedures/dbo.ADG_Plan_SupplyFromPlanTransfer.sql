 create proc ADG_Plan_SupplyFromPlanTransfer
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select	PlanDate,
		'Qty' = sum(Qty)

	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('28', '29')

	group by
		PlanDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_SupplyFromPlanTransfer] TO [MSDSL]
    AS [dbo];

