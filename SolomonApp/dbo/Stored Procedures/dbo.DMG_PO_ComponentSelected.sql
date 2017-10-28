 create procedure DMG_PO_ComponentSelected
	@KitID varchar(30),
	@KitStatus varchar(1)
as
	select	CmpnentID,
		CmpnentQty
	from	Component (NOLOCK)
	where	KitID = @KitID
	and	KitStatus = @KitStatus
	order by LineNbr


