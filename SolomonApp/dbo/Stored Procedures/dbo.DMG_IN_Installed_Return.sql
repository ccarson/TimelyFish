 CREATE PROCEDURE DMG_IN_Installed_Return
AS
	if (
	select	count(*)
	from	INSetup (NOLOCK)
	where	Init = 1
	) = 0
		return 0
	else
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_IN_Installed_Return] TO [MSDSL]
    AS [dbo];

