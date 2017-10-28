 create proc DMG_BOM_Components
	@KitID		varchar(30),
	@KitSiteID	varchar(10),
	@KitStatus	varchar(1),
	@MinSeq		varchar(5)

as
	select CmpnentID, SiteID, CmpnentQty, StockUsage,
		Status, Sequence,
		startDate, stopDate, SubKitStatus,
		KitID, KitSiteID, KitStatus
	from Component (NOLOCK)
		where  KitID = @KitID
		and KitSiteID = @KitSiteID
		and KitStatus = @KitStatus
		and Sequence >= @MinSeq

	order by KitID, SiteID, Sequence



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_BOM_Components] TO [MSDSL]
    AS [dbo];

