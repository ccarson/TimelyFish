 CREATE PROCEDURE DMG_OrdNbr_AddrSite
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@SiteID varchar(10)
AS
	select	distinct Site.*
	from	Site
	join	SOSched ON SOSched.ShipSiteID = Site.SiteID
	where	SOSched.CpnyID = @CpnyID
	and	SOSched.OrdNbr = @OrdNbr
	and	Site.SiteID like @SiteID
	order by Site.SiteID


