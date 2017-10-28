 create procedure DMG_PO_SOOrdNbrLineRef
	@InvtID		varchar(30),
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5) OUTPUT
as
	select	@LineRef = LineRef
	from	SOLine (NOLOCK)
	where	InvtID = @InvtID
	and	QtyOrd >= 0
	and	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr

	if @@ROWCOUNT <> 1
	begin
		set @LineRef = ''
		--select @LineRef
		return 0	--Failure
	end
	else
		--select @LineRef
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOOrdNbrLineRef] TO [MSDSL]
    AS [dbo];

