 create procedure DMG_ComponentSelected
	@KitID varchar(30)
as
	select	CmpnentID,
		CmpnentQty,
		Status = ltrim(rtrim(Status))
	from	Component (NOLOCK)
	where	KitId = @KitID
	order by LineNbr


