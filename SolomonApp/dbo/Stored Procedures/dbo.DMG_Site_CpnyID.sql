 CREATE PROCEDURE DMG_Site_CpnyID
	@CpnyID varchar(10),
	@SiteID varchar(10)
AS
	select	distinct Site.*
	from	Site
	join	LocTable on LocTable.SiteID = Site.SiteID and LocTable.SalesValid <> 'N'
	where	Site.CpnyID = @CpnyID
	and	Site.SiteID like @SiteID
	order by Site.CpnyID, Site.SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Site_CpnyID] TO [MSDSL]
    AS [dbo];

