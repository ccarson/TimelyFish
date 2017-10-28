 create proc ADG_ProcessMgr_SOScheds
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),	-- can be wildcard
	@SchedRef	varchar(5)	-- can be wildcard
as
	select	LineRef,
		SchedRef

	from	SOSched

	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr
	and	LineRef + '' like @LineRef
	and	SchedRef + '' like @SchedRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOScheds] TO [MSDSL]
    AS [dbo];

