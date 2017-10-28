 create proc DMG_Plan_MaxPlanRef
	@InvtID		varchar(30),
	@SiteID 	varchar(10),
	@PlanRef	decimal(25,9) OUTPUT
as
	select		@PlanRef = coalesce(convert(int, max(PlanRef)),0)
	from		SOPlan (NOLOCK)
	where		InvtID = @InvtID
	  and		SiteID = @SiteID

	if @@ROWCOUNT = 0 begin
		set @PlanRef = 0
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end


