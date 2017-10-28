 Create Procedure DMG_PO_SOSched_QtyOrd_UnitDesc
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@LineRef varchar(5),
	@SchedRef varchar(5),
	@QtyOrd decimal(25,9) OUTPUT,
	@UnitDesc varchar(6) OUTPUT
as
	select	@QtyOrd = SOSched.QtyOrd,
		@UnitDesc = ltrim(rtrim(UnitDesc))
	from	SOSched (NOLOCK)
	join	SOLine on SOLine.CpnyID = SOSched.CpnyID and SOLine.OrdNbr = SOSched.OrdNbr and SOLine.LineRef = SOSched.LineRef
	where	SOSched.CpnyID = @CpnyID
	and	SOSched.OrdNbr = @OrdNbr
	and	SOSched.LineRef = @LineRef
	and	SOSched.SchedRef = @SchedRef

	if @@ROWCOUNT = 0 begin
		set @QtyOrd = 0
		set @UnitDesc = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOSched_QtyOrd_UnitDesc] TO [MSDSL]
    AS [dbo];

