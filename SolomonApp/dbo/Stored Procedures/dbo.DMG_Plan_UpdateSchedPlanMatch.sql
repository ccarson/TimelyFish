 create proc DMG_Plan_UpdateSchedPlanMatch
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5),
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@PlanDate	smalldatetime,
	@PlanType	varchar(2),
	@PlanQty	decimal(25,9),
	@QtyPrecision	smallint
as
	update	SOPlan
	set	Qty = round(Qty + @PlanQty, @QtyPrecision),
		LUpd_DateTime = getdate(),
		LUpd_Prog = 'SQL',
		LUpd_User = 'SQL'
	where	CpnyID = @CpnyID
	and	SOOrdNbr = @OrdNbr
	and	SOLineRef = @LineRef
	and	SOSchedRef = @SchedRef
	and	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanDate = @PlanDate
	and	PlanType = @PlanType

	if @@ROWCOUNT = 0
		return 0	--Failure
	else
		return 1	--Success


