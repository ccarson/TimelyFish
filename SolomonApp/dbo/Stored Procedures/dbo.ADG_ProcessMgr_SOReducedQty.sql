 create proc ADG_ProcessMgr_SOReducedQty
	@CpnyID		varchar(10),
	@SOOrdNbr	varchar(15),
	@SOLineRef	varchar(5),
	@SOSchedRef	varchar(5),
	@TodaysDate	smalldatetime,
	@ProgID CHAR(8),
	@UserID Char(10)

as
	set nocount on

	-- Make sure no records exist in SOReducedQty.
	delete from SOReducedQty

	-- Insert into table SOReducedQty with the schedule and plan
	-- quantities and request dates for each specified schedule on
	-- the sales order.
	-- Cancelled orders and schedules with an item or site change
	-- are treated as if the open schedule quantity had dropped to zero.
	insert into SOReducedQty (InvtID, SiteID, SchedQty, PlanQty, SchedReqDate, PlanReqDate, Crtd_DateTime, Crtd_Prog,
		Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)
	select	p.InvtID,
		p.SiteID,
		'SchedQty' = case when h.Cancelled = 1 or s.CancelDate <= @TodaysDate
				then
					0
				else
					case
						when ((p.InvtID <> l.InvtID) or (p.SiteID <> coalesce(s.SiteID, ''))) then
							0
						else
							(coalesce(s.QtyOrd, 0) - coalesce(s.QtyShip, 0))
					end
				end,
		'PlanQty' = -p.Qty,
		'SchedReqDate' = coalesce(s.ReqDate,''),
		'PlanReqDate' = p.SOReqDate,
		getdate(), @ProgID, @UserID, GetDate(), @ProgId, @UserID
	from	SOPlan p

	join	SOHeader h
	on	h.CpnyID = p.CpnyID
	and	h.OrdNbr = p.SOOrdNbr

	left
	join	SOSched s
	on	s.CpnyID = p.CpnyID
	and	s.OrdNbr = p.SOOrdNbr
	and	s.LineRef = p.SOLineRef
	and	s.SchedRef = p.SOSchedRef

	join	SOLine l
	on	l.CpnyID = p.CpnyID
	and	l.OrdNbr = p.SOOrdNbr
	and	l.LineRef = p.SOLineRef

	where	p.CpnyID = @CpnyID
	and	p.SOOrdNbr = @SOOrdNbr
	and	p.SOLineRef like @SOLineRef
	and	p.SOSchedRef like @SOSchedRef

	option (force order)

	set nocount off

	-- Select from the temporary table the item/site combinations
	-- with a reduced quantity or a 'pushed out' request date.
	select		InvtID,
			SiteID

	from		SOReducedQty
	where		((coalesce(SchedQty, 0) < PlanQty) or (SchedReqDate > PlanReqDate))
	group by	InvtID,
			SiteID

	-- Make sure no records exist in SOReducedQty.
	delete from SOReducedQty



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOReducedQty] TO [MSDSL]
    AS [dbo];

