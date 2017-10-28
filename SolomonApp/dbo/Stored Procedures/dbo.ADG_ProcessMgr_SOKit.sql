 create proc ADG_ProcessMgr_SOKit
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select	BuildInvtID,
		BuildSiteID

	from	SOHeader

	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ProcessMgr_SOKit] TO [MSDSL]
    AS [dbo];

