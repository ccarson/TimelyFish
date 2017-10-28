 create proc ADG_Plan_FetchSchedPlan
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	select	*
	from	SOPlan

	where	CpnyID = @CpnyID
	and	SOOrdNbr = @OrdNbr
	and	SOLineRef = @LineRef
	and	SOSchedRef = @SchedRef
	and	PlanType in ('50', '52', '54', '60', '62', '64', '70')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_FetchSchedPlan] TO [MSDSL]
    AS [dbo];

