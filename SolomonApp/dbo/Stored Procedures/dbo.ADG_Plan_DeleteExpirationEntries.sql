
create proc ADG_Plan_DeleteExpirationEntries
	@InvtID 	varchar(30),
	@SiteID 	varchar(10)
as
	delete	SOPlan
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType = '66'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_DeleteExpirationEntries] TO [MSDSL]
    AS [dbo];

