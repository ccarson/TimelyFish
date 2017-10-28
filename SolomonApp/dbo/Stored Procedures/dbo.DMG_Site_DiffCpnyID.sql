 CREATE PROCEDURE DMG_Site_DiffCpnyID
	@CpnyID varchar(10),
	@SiteID varchar(10)
AS
	select	Count(*)
	from	Site
	where	Site.CpnyID <> @CpnyID
	and	Site.SiteID like @SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Site_DiffCpnyID] TO [MSDSL]
    AS [dbo];

