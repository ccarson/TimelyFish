 create procedure DMG_KitSelectedAll
	@KitID 		varchar(30)
as
	select 	ExpKitDet, KitType, SiteID, Status
	from	Kit (NOLOCK)
	where	Kit.KitId = @KitID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_KitSelectedAll] TO [MSDSL]
    AS [dbo];

