 create procedure DMG_PR_PurOrdDetSelected
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@LineRef	varchar(5),
	@QtyOrd		decimal(25,9) OUTPUT,
	@QtyRcvd	decimal(25,9) OUTPUT,
	@RcptPctAct	varchar(1) OUTPUT,
	@RcptPctMin	decimal(25,9) OUTPUT,
	@RcptPctMax	decimal(25,9) OUTPUT
as
	select	@QtyOrd = QtyOrd,
		@QtyRcvd = QtyRcvd,
		@RcptPctAct = ltrim(rtrim(RcptPctAct)),
		@RcptPctMax = RcptPctMax,
		@RcptPctMin = RcptPctMin
	from	PurOrdDet (NOLOCK)
        where 	PONbr = @PONbr
	and	LineRef = @LineRef

	if @@ROWCOUNT = 0 begin
		set @QtyOrd = 0
		set @QtyRcvd = 0
		set @RcptPctAct = ''
		set @RcptPctMax = 0
		set @RcptPctMin = 0
		return 0	--Failure
	end
	else
		return 1	--Success


