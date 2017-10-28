 create proc ADG_Plan_SupplyFromPlanPO
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select	PlanDate,
		Qty,
		'ShelfLife' = S4Future09

	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType = '20'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_SupplyFromPlanPO] TO [MSDSL]
    AS [dbo];

