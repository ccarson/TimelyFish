 create proc ADG_Plan_ItemSite_QtyAlloc
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	select	QtyAlloc
	from	ItemSite
	where	InvtID = @InvtID
	and	SiteID = @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_ItemSite_QtyAlloc] TO [MSDSL]
    AS [dbo];

