 create proc ADG_Plan_SupplyFromPlanInvt_CPSOff
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select	'QtyAvail' = (Qty)

	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType = '10'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_SupplyFromPlanInvt_CPSOff] TO [MSDSL]
    AS [dbo];

