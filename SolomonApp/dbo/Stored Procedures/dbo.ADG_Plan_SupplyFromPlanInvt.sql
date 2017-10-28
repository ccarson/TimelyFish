 create proc ADG_Plan_SupplyFromPlanInvt
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select	'QtyAvail' = (Qty - QtyShip)

	from	SOPlan

	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType = '10'


