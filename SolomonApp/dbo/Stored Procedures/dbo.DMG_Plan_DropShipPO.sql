 create proc DMG_Plan_DropShipPO
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5),
	@PONbr		varchar(10) OUTPUT,
	@POLineRef	varchar(5) OUTPUT,
	@AllocRef	varchar(5) OUTPUT
as
	select	@PONbr = ltrim(rtrim(a.PONbr)),
		@POLineRef = ltrim(rtrim(a.POLineRef)),
		@AllocRef = ltrim(rtrim(a.AllocRef))
	from	POAlloc a (NOLOCK)
	where	a.CpnyID = @CpnyID
	  and	a.SOOrdNbr = @OrdNbr
	  and	a.SOLineRef = @LineRef
	  and	a.SOSchedRef = @SchedRef

	if @@ROWCOUNT = 0 begin
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end


