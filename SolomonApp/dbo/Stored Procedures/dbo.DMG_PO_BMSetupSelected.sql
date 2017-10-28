 create procedure DMG_PO_BMSetupSelected
	@GlbSiteID	varchar(10) OUTPUT,
	@SiteBOM	smallint OUTPUT
as
	select	@GlbSiteID = ltrim(rtrim(GlbSiteID)),
		@SiteBOM = SiteBOM
	from	BMSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @GlbSiteID = ''
		set @SiteBOM = 0
		return 0	--Failure
	end
	else
		return 1	--Success


