 create procedure DMG_PO_SOLineRefSchedRef
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5) OUTPUT
as
	select	@SchedRef = SchedRef
	from	SOSched (NOLOCK)
	where	QtyOrd >= 0
	and	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr
	and	LineRef = @LineRef

	if @@ROWCOUNT <> 1
	begin
		set @SchedRef = ''
		--select @SchedRef
		return 0	--Failure
	end
	else
		--select @SchedRef
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOLineRefSchedRef] TO [MSDSL]
    AS [dbo];

