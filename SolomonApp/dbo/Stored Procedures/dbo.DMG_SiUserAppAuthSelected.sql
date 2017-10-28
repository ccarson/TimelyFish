 create procedure DMG_SiUserAppAuthSelected
	@UserID		varchar(47),
	@SiteID		varchar(10) OUTPUT
as
	select	@SiteID = ltrim(rtrim(SiteID))
	from	SiUserAppAuth (NOLOCK)
	where	UserID = @UserID

	if @@ROWCOUNT = 0 begin
		set @SiteID = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SiUserAppAuthSelected] TO [MSDSL]
    AS [dbo];

