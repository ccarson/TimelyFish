 create proc DMG_Plan_FixedPO
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5),
	@PONbr		varchar(10) OUTPUT,
	@POLineRef	varchar(5) OUTPUT,
	@AllocRef	varchar(5) OUTPUT,
	@QtyOrd		decimal(25,9) OUTPUT,
	@QtyRcvd	decimal(25,9) OUTPUT,
	@CnvFact	decimal(25,9) OUTPUT,
	@UnitMultDiv	varchar(1) OUTPUT,
	@PromDate	smalldatetime OUTPUT
as
	select	@PONbr = ltrim(rtrim(a.PONbr)),
		@POLineRef = ltrim(rtrim(a.POLineRef)),
		@AllocRef = ltrim(rtrim(a.AllocRef)),
		@QtyOrd = a.QtyOrd,
		@QtyRcvd = a.QtyRcvd,
		@CnvFact = l.CnvFact,
		@UnitMultDiv = ltrim(rtrim(l.UnitMultDiv)),
		@PromDate = l.PromDate
	from	POAlloc a (NOLOCK)
	  join	PurOrdDet l (NOLOCK)
	  on	l.PONbr = a.PONbr
	  and	l.LineRef = a.POLineRef
	  join	PurchOrd h (NOLOCK)
	  on	h.PONbr = a.PONbr
	where	a.CpnyID = @CpnyID
	  and	a.SOOrdNbr = @OrdNbr
	  and	a.SOLineRef = @LineRef
	  and	a.SOSchedRef = @SchedRef
	  and	h.POType = 'OR'
	  and	h.Status not in ('Q', 'X')	-- Quote, Cancelled

	if @@ROWCOUNT = 0 begin
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end


