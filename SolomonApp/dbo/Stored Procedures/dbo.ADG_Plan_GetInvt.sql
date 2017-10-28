 create proc ADG_Plan_GetInvt
	@InvtID		varchar(30),
	@SiteID 	varchar(10)

as
	select	*
	from	SOPlan
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType = '10'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_GetInvt] TO [MSDSL]
    AS [dbo];

