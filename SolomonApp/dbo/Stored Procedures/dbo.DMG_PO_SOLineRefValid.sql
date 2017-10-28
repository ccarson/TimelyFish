 create procedure DMG_PO_SOLineRefValid
	@InvtID		varchar(30),
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5)
as
	if (
	select	count(*)
	from	vp_SOSchedPO sos (NOLOCK)
	join	SOLine sol (NOLOCK) on sol.CpnyID = sos.CpnyID and sol.OrdNbr = sos.OrdNbr and sol.LineRef = sos.LineRef
	where	sol.InvtID = @InvtID
	and	sos.QtyOrd >= 0
	and	sos.CpnyID = @CpnyID
	and	sos.OrdNbr = @OrdNbr
	and	sos.LineRef = @LineRef
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOLineRefValid] TO [MSDSL]
    AS [dbo];

