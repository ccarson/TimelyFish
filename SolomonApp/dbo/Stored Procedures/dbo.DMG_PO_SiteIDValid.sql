 create procedure DMG_PO_SiteIDValid
	@CpnyID varchar(10),
	@SiteID	varchar(10)
as
	if (
	select	count(*)
	from	Site (NOLOCK)
	where	CpnyID = @CpnyID
	and	SiteID = @SiteID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_SiteIDValid] TO [MSDSL]
    AS [dbo];

