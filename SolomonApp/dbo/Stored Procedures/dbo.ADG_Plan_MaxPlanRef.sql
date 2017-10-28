 create proc ADG_Plan_MaxPlanRef
	@InvtID		varchar(30),
	@SiteID 	varchar(10)
as
	select		max(PlanRef)
	from		SOPlan

	where		InvtID = @InvtID
	and		SiteID = @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_MaxPlanRef] TO [MSDSL]
    AS [dbo];

