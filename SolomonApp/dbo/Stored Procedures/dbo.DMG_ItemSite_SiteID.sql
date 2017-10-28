 create procedure DMG_ItemSite_SiteID
	@InvtID varchar(30),
	@SiteID varchar(10) OUTPUT
as
	--The site id will be blank unless there is only one ItemSite record
	set @SiteID = ''

	--Get the count of the ItemSite records for the inventory item
	if (
	select	count(*)
	from	ItemSite (NOLOCK)
	where	InvtID = @InvtID
	) = 1
		--Return the site id from the one record if there is only one
		select	@SiteID = SiteID
		from	ItemSite (NOLOCK)
		where	InvtID = @InvtID

	--select @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemSite_SiteID] TO [MSDSL]
    AS [dbo];

