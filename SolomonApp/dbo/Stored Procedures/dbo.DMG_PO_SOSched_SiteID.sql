 Create Procedure DMG_PO_SOSched_SiteID
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@LineRef varchar(5),
	@SchedRef varchar(5),
	@SiteID varchar(10) OUTPUT
as
	select	@SiteID = ltrim(rtrim(SiteID))
	from	SOSched (NOLOCK)
	where	CpnyID = @CpnyID
	and	OrdNbr = @OrdNbr
	and	LineRef = @LineRef
	and	SchedRef = @SchedRef

	if @@ROWCOUNT = 0 begin
		set @SiteID = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SOSched_SiteID] TO [MSDSL]
    AS [dbo];

