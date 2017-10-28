 create procedure DMG_PO_SOOrdNbrLineInfo
	@InvtID		varchar(30),
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ProjID		varchar(16) OUTPUT,
	@TaskID		varchar(32) OUTPUT
as
	select	@ProjID = ProjectID,
		@TaskID = TaskID
	from	SOLine (NOLOCK)
	where	InvtID = @InvtID
	and	QtyOrd >= 0
	and	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr

	if @@ROWCOUNT <= 0  
	begin
		set @ProjID = ''
		set @TaskID = ''
		return 0	--Failure
	end
	else
		--select @LineRef
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOOrdNbrLineInfo] TO [MSDSL]
    AS [dbo];

