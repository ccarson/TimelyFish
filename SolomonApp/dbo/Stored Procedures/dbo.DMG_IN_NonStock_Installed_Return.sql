 CREATE PROCEDURE DMG_IN_NonStock_Installed_Return
AS
	if (
	select	count(*)
	from	INSetup (NOLOCK)
	where	Init = 0
	) = 0
		return 0
	else
		return 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_IN_NonStock_Installed_Return] TO [MSDSL]
    AS [dbo];

