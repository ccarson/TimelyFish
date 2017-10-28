 create proc DMG_UpdateAll_GetItemSite_IS
	@InvtIDParm		varchar(30),
	@SiteIDParm		varchar(10)
as
	select		invtid, siteid
	from		ItemSite
	where 		InvtID like @InvtIDParm and SiteID like @SiteIDParm
	order by	invtid, siteid


