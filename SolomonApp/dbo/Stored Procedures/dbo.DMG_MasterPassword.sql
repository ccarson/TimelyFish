
create procedure DMG_MasterPassword
	@CurrentPassword	varchar(30) OUTPUT
as
	select @CurrentPassword = CurrentPassword
	from	Domain (NOLOCK)
	where	Description = 'MASTER Login Password'

	if @@ROWCOUNT = 0 begin
		set @CurrentPassword = ''
		return 0	--Failure
	end
	else
		return 1	--Success


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DMG_MasterPassword] TO PUBLIC
    AS [dbo];

