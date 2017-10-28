 create proc DMG_Site_Selected_DMGSite
	@SiteID 			varchar(10),
	@AlwaysShip			smallint OUTPUT,
	@NeverAutoCreateShippers	smallint OUTPUT
as
	select	@AlwaysShip = convert(smallint, S4Future09),
		@NeverAutoCreateShippers = convert(smallint, S4Future10)
	from	Site (NOLOCK)
	where	SiteID = @SiteID

	if @@ROWCOUNT = 0 begin
		set @AlwaysShip = 0
		set @NeverAutoCreateShippers = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Site_Selected_DMGSite] TO [MSDSL]
    AS [dbo];

