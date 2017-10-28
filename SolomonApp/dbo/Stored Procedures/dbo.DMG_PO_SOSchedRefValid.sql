 create procedure DMG_PO_SOSchedRefValid
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	if (
	select	count(*)
	from	vp_SOSchedPO (NOLOCK)
	where	QtyOrd >= 0
	and	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr
	and	LineRef = @LineRef
	and	SchedRef = @SchedRef
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOSchedRefValid] TO [MSDSL]
    AS [dbo];

