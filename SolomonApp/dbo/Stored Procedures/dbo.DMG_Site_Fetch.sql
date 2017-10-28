 create proc DMG_Site_Fetch
	@SiteID 	varchar(10)
as
	select	convert(smallint, S4Future09),	-- AlwaysShip
		convert(smallint, S4Future10)	-- NeverAutoCreateShippers

	from	Site
	where	SiteID = @SiteID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Site_Fetch] TO [MSDSL]
    AS [dbo];

