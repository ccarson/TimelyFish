 create proc ADG_Plan_PrevDemand
	@InvtID 	varchar(30),
	@SiteID 	varchar(10),
	@Priority	smallint
as
	select	PlanDate,
		SOETADate,
		Qty = -Qty,
		CpnyID,
		SOOrdNbr,
		SOLineRef,
		PlanRef

	from	Inventory i (nolock)

	join	SOPlan p
	on	p.InvtID = i.InvtID

	where	p.InvtID = @InvtID
	and	p.SiteID = @SiteID
	and	p.PlanType in ('60', '62', '64','50','52')	-- Floating demand
        and     p.Priority <= Case when p.Plantype = '50' then 9 Else @Priority End
        and     p.Hold = Case when p.plantype in ('50','52') then 0 Else p.Hold end
	and	i.StkItem = 1
	and	i.InvtID = @InvtID

	order by
		p.PrioritySeq,
		p.Priority,
		p.PriorityDate,
		p.PriorityTime


