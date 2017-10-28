 CREATE PROCEDURE DMG_SOHeader_OrdNbr_SiteID
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@SiteID varchar(10)
AS
	select	distinct Site.*
	from	Site
	join	SOSched on SOSched.CpnyID = Site.CpnyID and SOSched.SiteID = Site.SiteID
	where	SOSched.CpnyID = @CpnyID
	and	SOSched.OrdNbr = @OrdNbr
	and	Site.SiteID like @SiteID
	order by Site.CpnyID, Site.SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOHeader_OrdNbr_SiteID] TO [MSDSL]
    AS [dbo];

