 create proc ADG_Plan_DeleteSchedPlanItem
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5),
	@InvtID 	varchar(30),
	@SiteID 	varchar(10)
as
	delete	SOPlan

	where	CpnyID = @CpnyID
	and	SOOrdNbr = @OrdNbr
	and	SOLineRef = @LineRef
	and	SOSchedRef = @SchedRef
	and	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('50', '52', '54', '60', '62', '64', '70')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_DeleteSchedPlanItem] TO [MSDSL]
    AS [dbo];

