 create procedure DMG_UserSlsperSelected
	@UserID		varchar(47)
as
	select	ltrim(rtrim(SlsperID)) SlsperID,
		CreditPct
	from	UserSlsper (NOLOCK)
	where	UserID = @UserID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_UserSlsperSelected] TO [MSDSL]
    AS [dbo];

