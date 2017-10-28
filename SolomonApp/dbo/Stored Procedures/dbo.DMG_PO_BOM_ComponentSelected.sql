 create procedure DMG_PO_BOM_ComponentSelected
	@KitID varchar(30),
	@KitSiteID varchar(10),
	@KitStatus varchar(1)
as
	select	CmpnentID,
		CmpnentQty
	from	Component (NOLOCK)
	where	KitID = @KitID
	and	KitSiteID = @KitSiteID
	and	KitStatus = @KitStatus
	order by LineNbr


