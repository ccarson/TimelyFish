 create proc ADG_Plan_FixedPO
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	select	a.PONbr,
		a.POLineRef,
		a.AllocRef,
		a.QtyOrd,
		a.QtyRcvd,
		l.CnvFact,
		l.UnitMultDiv,
		l.PromDate

	from	POAlloc a

	join	PurOrdDet l
	on	l.PONbr = a.PONbr
	and	l.LineRef = a.POLineRef

	join	PurchOrd h
	on	h.PONbr = a.PONbr

	where	a.CpnyID = @CpnyID
	and	a.SOOrdNbr = @OrdNbr
	and	a.SOLineRef = @LineRef
	and	a.SOSchedRef = @SchedRef
	and	h.POType = 'OR'
	and	h.Status not in ('Q', 'X')	-- Quote, Cancelled



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_FixedPO] TO [MSDSL]
    AS [dbo];

