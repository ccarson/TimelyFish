 create procedure DMG_ItemSiteValid
	@InvtID varchar(30),
	@SiteID varchar(10)
as
	if (
	select	count(*)
	from	ItemSite (NOLOCK)
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemSiteValid] TO [MSDSL]
    AS [dbo];

