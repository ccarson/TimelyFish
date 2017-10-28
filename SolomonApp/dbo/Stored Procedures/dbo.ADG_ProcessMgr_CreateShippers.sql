 create proc ADG_ProcessMgr_CreateShippers
as
	select		p.CpnyID,
			p.SOOrdNbr,
			convert(float, min(p.PriorityScore)) PriorityScore	-- make sure this is a float

	from		(select	CpnyID,
				SOOrdNbr,
				(cast(PlanDate as float) * 1000000)
					+ (Priority * 100000)
					+ (floor(cast(PriorityDate as float)))
					+ (cast(PriorityTime as float) - floor(cast(PriorityTime as float))) PriorityScore
			from	SOPlan
			where	PlanType in ('50', '52', '54', '60', '61', '62', '64')) p
	join		SOHeader h
	on		h.CpnyID = p.CpnyID
	and		h.OrdNbr = p.SOOrdNbr

	where		h.AdminHold = 0
	and		h.NextFunctionID = '4041000'
	and		h.NextFunctionClass = ''

	group by	p.CpnyID,
			p.SOOrdNbr

	order by	PriorityScore


