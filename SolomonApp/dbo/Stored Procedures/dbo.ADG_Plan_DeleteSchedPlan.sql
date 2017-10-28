 create proc ADG_Plan_DeleteSchedPlan
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	delete	SOPlan

	where	CpnyID = @CpnyID
	and	SOOrdNbr = @OrdNbr
	and	SOLineRef = @LineRef
	and	SOSchedRef = @SchedRef
	and	PlanType in ('50', '52', '54', '60', '61', '62', '64', '70')	-- Sales Order demand types



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_DeleteSchedPlan] TO [MSDSL]
    AS [dbo];

