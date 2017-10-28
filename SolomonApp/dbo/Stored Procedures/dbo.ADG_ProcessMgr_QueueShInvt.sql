 create proc ADG_ProcessMgr_QueueShInvt
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	declare		@CpnyID		varchar(10)
	declare		@OrdNbr		varchar(15)
	declare		@PriorityScore	float

	declare		SOPlanCursor	cursor
	for select	CpnyID,
			SOOrdNbr,
			convert(float, min((cast(PlanDate as float) * 1000000)
				+ (Priority * 100000)
				+ (floor(cast(PriorityDate as float)))
				+ (cast(PriorityTime as float) - floor(cast(PriorityTime as float))))) PriorityScore
			from	SOPlan
			where	InvtID = @InvtID
				and SiteID = @SiteID
				and PlanType in ('50', '52', '54', '60', '62', '64')
				and SOReqShipDate < getdate() + 3
			group by CpnyID, SOOrdNbr
			order by PriorityScore

	open		SOPlanCursor

	fetch next from	SOPlanCursor
	into		@CpnyID,
			@OrdNbr,
			@PriorityScore

	while (@@fetch_status = 0)
	begin
		exec ADG_ProcessMgr_QueueSOSh @CpnyID, @OrdNbr

		fetch next from	SOPlanCursor
		into		@CpnyID,
				@OrdNbr,
				@PriorityScore
	end

	close		SOPlanCursor
	deallocate	SOPlanCursor


